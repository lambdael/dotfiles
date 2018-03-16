# dotfiles
my dotfiles

partition
https://wiki.archlinux.jp/index.php/EFI_%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%83%91%E3%83%BC%E3%83%86%E3%82%A3%E3%82%B7%E3%83%A7%E3%83%B3


    # fdisk /dev/sda # (or whatever device you want to install on)
    # mkfs.ext4 -L nixos /dev/sda1
    # mkswap -L swap /dev/sda2
    # swapon /dev/sda2
    # mount /dev/disk/by-label/nixos /mnt
    # nixos-generate-config --root /mnt
    # nano /mnt/etc/nixos/configuration.nix
    # nixos-install
    # passwd user
    # reboot

