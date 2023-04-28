# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxml2"
PKG_VERSION="2.11.1"
PKG_SHA256="624fff6054c13382c54ac5d150ac67af52d5d58d141886f4d1bbb912e31cf02b"
PKG_LICENSE="MIT"
PKG_SITE="http://xmlsoft.org"
PKG_URL="https://gitlab.gnome.org/GNOME/${PKG_NAME}/-/archive/v${PKG_VERSION}/${PKG_NAME}-v${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="zlib:host Python3:host"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="The libxml package contains an XML library, which allows you to manipulate XML files."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_ALL="ac_cv_header_ansidecl_h=no \
                        --enable-static \
                        --enable-shared \
                        --disable-silent-rules \
                        --enable-ipv6 \
                        --without-lzma"

PKG_CONFIGURE_OPTS_HOST="${PKG_CONFIGURE_OPTS_ALL} \
                         --with-zlib=${TOOLCHAIN} \
                         --with-python"

PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_ALL} \
                           --with-zlib=${SYSROOT_PREFIX}/usr \
                           --without-python \
                           --with-sysroot=${SYSROOT_PREFIX}"

post_makeinstall_target() {
  sed -e "s:\(['= ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/bin/xml2-config

  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/lib/xml2Conf.sh
}
