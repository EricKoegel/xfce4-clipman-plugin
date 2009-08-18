#!/bin/sh
#
# $Id: autogen.sh 23241 2006-09-29 19:05:15Z kelnos $
#
# Copyright (c) 2002-2005
#         The Xfce development team. All rights reserved.
#
# Written for Xfce by Benedikt Meurer <benny@xfce.org>.
#

(type xdt-autogen) >/dev/null 2>&1 || {
  cat >&2 <<EOF
autogen.sh: You don't seem to have the Xfce development tools installed on
            your system, which are required to build this software.
            Please install the xfce4-dev-tools package first, available from
            http://xfce.org/~benny/projects/xfce4-dev-tools/.
EOF
  exit 1
}

echo 'dnl *** This file is automatically generated from configure.ac.in ***' \
    >configure.ac
echo 'dnl *** DO NOT EDIT! ***' >>configure.ac
echo >>configure.ac

# substitute revision and linguas
linguas=$(ls po/*.po 2>/dev/null | awk 'BEGIN {FS="[./]"; ORS=" "} {print $2}')
if [ -d .git ]; then
    revision=$(git log --pretty=format:%h -n 1)
else
    revision=UNKNOWN
fi
sed -e "s/@LINGUAS@/${linguas}/g" \
    -e "s/@REVISION@/${revision}/g" \
    < configure.ac.in >> configure.ac

xdt-autogen $@

# vi:set ts=2 sw=2 et ai:
