#!/bin/bash

mount -t sysfs none ./root/sys
mount -t proc none ./root/proc
mount -o bind /dev ./root/dev
mount -o bind .. ./root/mnt

function unchroot {
    umount ./root/mnt
    umount ./root/dev
    umount ./root/proc
    umount ./root/sys
}
trap unchroot EXIT

cp build.sh ./root
chroot ./root /bin/bash -c '. /etc/profile; /build.sh'