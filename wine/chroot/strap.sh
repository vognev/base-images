#!/bin/bash

DEBOOTSTRAP=`which debootstrap`

mkdir -p root

$DEBOOTSTRAP --arch amd64 --variant=minbase --components=main\
 jessie ./root http://ftp.debian.org/debian
