#!/bin/bash

[ $UID -eq 0 ] || {
	echo "This script must be run as root."
	exit 1
}

cd /mnt/smgl

case $1 in
0)
	umount -v sys/firmware/efi/efivars
	umount -v sys
	umount -v proc
	umount -v dev/pts
	umount -v dev/shm
	umount -v dev
	umount -v tmp2
	umount -v run
	;;
1)
	mount -v --bind /dev dev
	mount -vt devpts none dev/pts
	mount -vt tmpfs -o size=10M tmpfs dev/shm
	mount -v --bind /sys sys
	mount -v --bind /sys/firmware/efi/efivars sys/firmware/efi/efivars
	mount -v --bind /proc proc
	mount -vt tmpfs -o size=250M,mode=1777 tmpfs tmp2
	mount -v --bind /run run
	mkdir -v run/lock 2>/dev/null
	;;
2)
	chroot . /bin/env -i SHELL=/bin/bash HOME=/root \
		PWD=/root PS1='\[\e[01;30m\]\t\[\e[00;32m\]\u@lt16:\l:\w\$\[\e[00m\] ' \
		TERM=linux /bin/bash -l
	;;
esac

