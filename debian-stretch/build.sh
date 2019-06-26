#!/usr/bin/env bash

set -e
set -x

# debootstrap
cd /build && mkdir -p rootfs
apt-get update && apt-get install -y debootstrap
debootstrap --variant=minbase stretch ./rootfs http://cdn-fastly.deb.debian.org/debian

# remove packages not needed in container
./chroot.sh ./rootfs apt-get remove -y --purge --allow-remove-essential e2fsprogs e2fslibs
./chroot.sh ./rootfs apt-get remove -y --purge --allow-remove-essential ncurses-base ncurses-bin
./chroot.sh ./rootfs apt-get remove -y --purge --allow-remove-essential mount libfdisk1

# install packages needed in container
./chroot.sh ./rootfs apt-get install -y runit netcat util-linux

# configure dpkg
mkdir -p ./rootfs/etc/dpkg/dpkg.cfg.d
echo "log /dev/null" > ./rootfs/etc/dpkg/dpkg.cfg.d/lognull
cat > ./rootfs/etc/dpkg/dpkg.cfg.d/pathexclude <<EOF
path-exclude=/usr/share/doc/*
path-exclude=/usr/share/man/*
path-exclude=/usr/share/info/*
path-exclude=/etc/cron.*
EOF

# configure apt
mkdir -p /etc/apt/apt.conf.d
cat > ./rootfs/etc/apt/apt.conf.d/nocache <<EOF
      DPkg::Post-Invoke  { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };
APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };
Dir::Cache::pkgcache "";
Dir::Cache::srcpkgcache "";
EOF

cat > ./rootfs/etc/apt/apt.conf.d/no-recommends-suggests <<EOF
APT::Get::Install-Recommends "false";
APT::Get::Install-Suggests "false";
EOF

# disable initscripts in container
cat > ./rootfs/usr/sbin/policy-rc.d <<EOF
#!/bin/sh
# For most Docker users, "apt-get install" only happens during "docker build",
# where starting services doesn't work and often fails in humorous ways. This
# prevents those failures by stopping the services from attempting to start.
exit 101
EOF

chmod +x ./rootfs/usr/sbin/policy-rc.d

./chroot.sh ./rootfs dpkg-divert --local --rename --add /sbin/initctl
./chroot.sh ./rootfs cp -a /usr/sbin/policy-rc.d /sbin/initctl
./chroot.sh ./rootfs sed -i -e 's/^exit.*/exit 0/' /sbin/initctl
./chroot.sh ./rootfs ln -s /bin/true /sbin/runlevel

# add debian user
./chroot.sh ./rootfs useradd -u 1000 -m debian

# remove misc files not needed in container
./chroot.sh ./rootfs find /usr/share/doc/ -type f -delete
./chroot.sh ./rootfs find /usr/share/man/ -type f -delete
./chroot.sh ./rootfs find /usr/share/info/ -type f -delete

# cleanup
./chroot.sh ./rootfs find /var/cache/apt -type f -delete
./chroot.sh ./rootfs find /var/lib/apt/lists -type f -delete
./chroot.sh ./rootfs find /var/log -type f -delete

# tar final rootfs
tar czf rootfs.tar.gz -C /build/rootfs --one-file-system .
rm -rf /build/rootfs