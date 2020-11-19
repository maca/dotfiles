Install notes
=============


## Cryptroot


```
$ sudo cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/sda2
$ sudo cryptsetup open /dev/sda2 cryptroot
$ sudo mkfs.ext4 /dev/mapper/cryptroot
$ sudo mount /dev/mapper/cryptroot /mnt
```

Mount /mnt and /mnt/boot

```
$ sudo pacstrap /mnt base base-devel vim zsh dialog netctl dhcpcd git refind sudo linux linux-firmware
$ genfstab -U /mnt | sudo tee /mnt/etc/fstab
$ sudo arch-chroot /mnt
```

```
# refind-install
```

Configuring mkinitcpio
Add the keyboard, keymap and encrypt hooks to mkinitcpio.conf. If the default US keymap is fine for you, you can omit the keymap hook.

```
HOOKS=(base udev autodetect keyboard consolefont modconf block encrypt filesystems fsck)
```

```
# mkinitcpio -P
```