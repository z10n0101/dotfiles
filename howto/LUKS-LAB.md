Dokumentacija Setup-a: Pentest & Scaling Lab

Hardver: Samsung Evo 500GB SSD (nvme0n1)

OS: Fedora (Host) + Kali Linux (VM) + Incus (Kontejneri)
1. Priprema Diska i Enkripcija (LUKS)

Cilj je bio da se drugi disk otključava istom lozinkom kao i primarni sistem.
Bash

# Kreiranje particije
sudo parted /dev/nvme0n1 mklabel gpt
sudo parted /dev/nvme0n1 mkpart primary btrfs 0% 100%

# Enkripcija (koristiti istu lozinku kao na nvme1n1)
sudo cryptsetup luksFormat /dev/nvme0n1p1
sudo cryptsetup open /dev/nvme0n1p1 luks-lab

2. Btrfs Struktura (Subvolumes)

Napravili smo fleksibilne particije koje dele sav prostor na disku.
Bash

# Formatiranje
sudo mkfs.btrfs -L "LAB_STORAGE" /dev/mapper/luks-lab

# Kreiranje subvolume-a
sudo mount /dev/mapper/luks-lab /mnt
sudo btrfs subvolume create /mnt/@vms
sudo btrfs subvolume create /mnt/@incus
sudo btrfs subvolume create /mnt/@docker
sudo btrfs subvolume create /mnt/@shared
sudo umount /mnt

3. Automatsko montiranje (/etc/crypttab & /etc/fstab)

Da bi se disk otključao i montirao pri boot-u.

U /etc/crypttab dodato:
luks-lab UUID=<UUID_PARTICIJE> none luks,timeout=180

U /etc/fstab dodato:
Plaintext

/dev/mapper/luks-lab  /var/lib/libvirt/images  btrfs  subvol=@vms,compress=zstd,noatime,nodiscard  0 0
/dev/mapper/luks-lab  /var/lib/incus           btrfs  subvol=@incus,compress=zstd,noatime        0 0
/dev/mapper/luks-lab  /var/lib/docker          btrfs  subvol=@docker,compress=zstd,noatime       0 0
/dev/mapper/luks-lab  /mnt/shared              btrfs  subvol=@shared,compress=zstd,noatime       0 0

4. Optimizacija Performansi (No-CoW)

Isključivanje Copy-on-Write za baze podataka i VM slike radi brzine.
Bash

sudo mkdir -p /var/lib/libvirt/images /var/lib/incus /var/lib/docker /mnt/shared
sudo mount -a
sudo chattr +C /var/lib/libvirt/images
sudo chattr +C /var/lib/docker
sudo chown z10n0101:z10n0101 /mnt/shared

5. Virtuelizacija: Kali Linux (KVM/QEMU)

Uvoz pre-built Kali slike u novi storage pool.
Bash

# Postavljanje permisija za sliku
sudo cp kali.qcow2 /var/lib/libvirt/images/kali.qcow2
sudo chown qemu:qemu /var/lib/libvirt/images/kali.qcow2

# Instalacija/Uvoz VM
virt-install \
--connect qemu:///system \
--name kali-pentest \
--memory 4096 \
--vcpus 4 \
--disk path=/var/lib/libvirt/images/kali.qcow2,bus=virtio \
--os-variant debian12 \
--network network=default \
--graphics spice \
--import \
--noautoconsole

# Snapshot (Zlatna slika)
virsh --connect qemu:///system snapshot-create-as --domain kali-pentest --name "fresh-install"

6. Kontejnerizacija: Incus & Docker Swarm

Podešavanje Incus-a na Btrfs subvolume-u i kreiranje klastera.
Bash

# Inicijalizacija Incusa (Backend: btrfs, Path: /var/lib/incus)
incus admin init

# Kreiranje 3 čvora za Swarm
for i in {1..3}; do 
  incus launch images:fedora/41 node$i -c security.nesting=true
done

# Instalacija Docker-a na čvorovima
incus exec node1 -- dnf install -y docker-ce
incus exec node1 -- systemctl enable --now docker

# Swarm Init (na node1)
incus exec node1 -- docker swarm init

Napomena: Za sve buduće VM, diskove uvek smeštaj u /var/lib/libvirt/images kako bi iskoristio brzinu Samsung SSD-a i prednosti Btrfs subvolume-a.
