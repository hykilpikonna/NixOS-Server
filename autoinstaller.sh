# https://www.vultr.com/docs/how-to-install-nixos-on-a-vultr-vps
mkdir ~/.ssh
curl -L https://github.com/Hykilpikonna.keys >~/.ssh/authorized_keys

sudo -s

parted /dev/vda -s 'mklabel msdos'
parted /dev/vda -s 'mkpart primary 1MiB -1GiB'
parted /dev/vda -s 'mkpart primary linux-swap -1GiB 100%'

mkfs.btrfs -L root /dev/vda1
mkswap -L swap /dev/vda2
swapon /dev/vda2
mount /dev/disk/by-label/root /mnt

nixos-generate-config --root /mnt
cd /mnt/etc
nix-shell -p git --run 'git clone https://github.com/hykilpikonna/NixOS-Server.git temp'
rm -rf temp/hardware-configuration.nix
mv -f temp/* nixos/

cp /home/nixos/.ssh/authorized_keys /mnt/etc/nixos/key.pub

nix-shell -p git --run 'nixos-install --no-root-passwd'

echo "Done!"
echo "Please shut down and remove installer iso."
