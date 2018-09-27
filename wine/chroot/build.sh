#!/bin/bash

set -e
set -x

BUILD_DEPS=(
    build-essential
    gcc-multilib
    flex
    bison
)

MAKE_DEPS_64=(
    zlib1g-dev
    libxml2-dev
    libx11-dev
    libxcursor-dev
    libxi-dev
    libfreetype6-dev
    libfontconfig1-dev
    libpng-dev
    libjpeg-dev
)

MAKE_DEPS_32=(
    zlib1g-dev:i386
    libxml2-dev:i386
    libx11-dev:i386
    libxcursor-dev:i386
    libxi-dev:i386
    libfreetype6-dev:i386
    libfontconfig1-dev:i386
    libpng-dev:i386
    libjpeg-dev:i386
)

CONFIGURE_OPTS=(
    --without-alsa
    --without-capi
    --without-cms
    --without-coreaudio
    --without-cups
    --without-curses
    --without-dbus
    --without-gettext
    --without-gphoto
    --without-glu
    --without-gnutls
    --without-gsm
    --without-gstreamer
    --without-hal
    --without-krb5
    --without-ldap
    --without-mpg123
    --without-netapi
    --without-openal
    --without-opencl
    --without-opengl
    --without-osmesa
    --without-oss
    --without-pcap
    --without-pulse
    --without-sane
    --without-tiff
    --without-udev
    --without-v4l
    --without-xcomposite
    --without-xinerama
    --without-xrandr
    --without-xshape
    --without-xshm
    --without-xslt
    --without-xxf86vm
    --with-zlib
)

dpkg --add-architecture i386 && apt-get update

# install compilers and tools
apt-get install -y wget ${BUILD_DEPS[@]}

# download sources
mkdir -p /wine && cd /wine
mkdir -p wine32 wine64
wget -c -o /dev/null https://dl.winehq.org/wine/source/2.x/wine-2.22.tar.xz

if [ ! -d wine-2.22 ]; then
    tar xf wine-2.22.tar.xz
fi

export CFLAGS="${CFLAGS} -Os"
export CXXFLAGS="${CFLAGS}"

# build wine64
mkdir -p /wine/wine64 && cd /wine/wine64

apt-get install -y ${MAKE_DEPS_64[@]}
if [ ! -f Makefile ]; then
    ../wine-2.22/configure --prefix=/opt/wine --libdir=/opt/wine/lib --enable-win64 ${CONFIGURE_OPTS[@]}
fi
make -j $(nproc)

# build wine32
mkdir -p /wine/wine32 && cd /wine/wine32

apt-get install -y ${MAKE_DEPS_32[@]}
if [ ! -f Makefile ]; then
    ../wine-2.22/configure --prefix=/opt/wine --libdir=/opt/wine/lib32 --with-wine64=/wine/wine64 ${CONFIGURE_OPTS[@]}
fi
make -j $(nproc)

# install
rm -rf /opt/wine
cd /wine/wine32 && make prefix=/opt/wine libdir=/opt/wine/lib32 dlldir=/opt/wine/lib32/wine install
cd /wine/wine64 && make prefix=/opt/wine libdir=/opt/wine/lib   dlldir=/opt/wine/lib/wine   install

# post-install cleanup
rm -rf /opt/wine/{lib,lib32}/wine/d3d*
rm -rf /opt/wine/{lib,lib32}/wine/xinput*
rm -rf /opt/wine/{lib,lib32}/wine/dinput*
rm -rf /opt/wine/{lib,lib32}/wine/dplay*
rm -rf /opt/wine/{lib,lib32}/wine/dsound*
rm -rf /opt/wine/{lib,lib32}/wine/dxdiag*
rm -rf /opt/wine/{lib,lib32}/wine/twain*
rm -rf /opt/wine/{lib,lib32}/wine/wined3d*
rm -rf /opt/wine/{lib,lib32}/wine/dmusic*
rm -rf /opt/wine/{lib,lib32}/wine/wordpad*
rm -rf /opt/wine/{lib,lib32}/wine/winhlp32*
rm -rf /opt/wine/{lib,lib32}/wine/winemine*
rm -rf /opt/wine/{lib,lib32}/wine/notepad*
rm -rf /opt/wine/{lib,lib32}/wine/opengl32*
rm -rf /opt/wine/{lib,lib32}/wine/dbghelp*
rm -rf /opt/wine/{lib,lib32}/wine/winedbg*
rm -rf /opt/wine/include
rm -rf /opt/wine/share/applications
rm -rf /opt/wine/share/man

tar czf /mnt/wine.tar.gz /opt/wine

# todo: tar wine.tar.gz without deleted; tar deleted additionally for full package