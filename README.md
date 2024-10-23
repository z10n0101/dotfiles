# dotfiles

```
mkdir .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo !! >>.bashrc
```

## Create github repo online that pull or create it localy (not working anymore like this, use gh command instead)
```
dotfiles init
dotfiles branch -M main
dotfiles config --local status.showUntrackedFiles no
```

## Add files
```
dotfiles add .bashrc
dotfiles remote add origin git@github.com:z10n0101/dotfiles.git
dotfiles push -u origin main
```

# Second machine

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:z10n0101/dotfiles.git $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
# If you have errors (dot files already exists) -> backup current dot files than:
dotfiles checkout
```
