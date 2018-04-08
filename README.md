# dotfiles
my dotfiles

use nix-home

    nix-prefetch-git https://github.com/lambdael/dotfiles.git

    cp /home/lambdael/projects/dotfiles/default.nix ~/
    nix-home


for urxvt

    xrdb -merge .Xresources

