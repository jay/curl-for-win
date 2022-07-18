#!/bin/sh

# Copyright 2014-present Viktor Szakats. See LICENSE.md

# WARNING: libssh uses hard-coded world-writable paths (/etc/..., ~/.ssh/) to
#          read its configuration from, making it vulnerable to attacks on
#          Windows. Do not use this component till these are fixed.

# shellcheck disable=SC3040
set -o xtrace -o errexit -o nounset; [ -n "${BASH:-}${ZSH_NAME:-}" ] && set -o pipefail

export _NAM _VER _OUT _BAS _DST

_NAM="$(basename "$0" | cut -f 1 -d '.' | sed 's/-cmake//')"
_VER="$1"

(
  cd "${_NAM}" || exit 0

  rm -r -f "${_PKGDIR}" "${_BLDDIR}"

  CPPFLAGS=''
  LIBS=''
  options=''

  if [ -d ../zlib ]; then
    options="${options} -DZLIB_LIBRARY=${_TOP}/zlib/${_PP}/lib/libz.a"
    options="${options} -DZLIB_INCLUDE_DIR=${_TOP}/zlib/${_PP}/include"
  fi

  if [ -n "${_OPENSSL}" ]; then
    options="${options} -DOPENSSL_ROOT_DIR=${_TOP}/${_OPENSSL}/${_PP}"
    options="${options} -DOPENSSL_INCLUDE_DIR=${_TOP}/${_OPENSSL}/${_PP}/include"
    if [ "${_OPENSSL}" = 'boringssl' ]; then

      # FIXME (upstream):
      # - It collides with wincrypt.h macros. Workaround:
      CPPFLAGS="${CPPFLAGS} -DNOCRYPT -D__WINCRYPT_H__"
      # - Wants to compile libcrypto_compat.c and assumes pre-OpenSSL 1.1
      #   non-opaque structures. Workaround:
      echo > src/libcrypto-compat.c
      # - Detects HAVE_OPENSSL_CRYPTO_CTR128_ENCRYPT, and assumes it means
      #   openssl/modes.h also exists, but with BoringSSL, it does not. Workaround:
      [ -d include/openssl ] || mkdir -p include/openssl
      touch include/openssl/modes.h

      CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
      LIBS="${LIBS} -lpthread"  # to detect EVP_aes_128_*
    elif [ "${_OPENSSL}" = 'libressl' ]; then
      LIBS="${LIBS} -lbcrypt"
      LIBS="${LIBS} -lws2_32"  # to detect EVP_aes_128_*
    elif [ "${_OPENSSL}" = 'openssl-quic' ] || [ "${_OPENSSL}" = 'openssl' ]; then
      CPPFLAGS="${CPPFLAGS} -DOPENSSL_SUPPRESS_DEPRECATED"
      LIBS="${LIBS} -lbcrypt"
      LIBS="${LIBS} -lws2_32"  # to detect EVP_aes_128_*
    fi
  elif [ -d ../mbedtls ]; then
    if false; then
      # Compile errors as of mbedTLS 3.2.1 + libssh 0.9.6
      options="${options} -DWITH_MBEDTLS=ON"
      options="${options} -DMBEDTLS_ROOT_DIR=${_TOP}/mbedtls/${_PP}"
      options="${options} -DMBEDTLS_INCLUDE_DIR=${_TOP}/mbedtls/${_PP}/include"
    fi
  fi

  # shellcheck disable=SC2086
  cmake . -B "${_BLDDIR}" ${_CMAKE_GLOBAL} ${options} \
    '-DGLOBAL_CLIENT_CONFIG=C:/Windows/System32/ssh/ssh_config' \
    '-DGLOBAL_BIND_CONFIG=C:/Windows/System32/ssh/libssh_server_config' \
    '-DBUILD_SHARED_LIBS=OFF' \
    '-DWITH_SERVER=OFF' \
    '-DWITH_EXAMPLES=OFF' \
    '-DUNIT_TESTING=OFF' \
    "-DCMAKE_C_FLAGS=-Wno-unused-command-line-argument ${_CFLAGS_GLOBAL} ${_CPPFLAGS_GLOBAL} ${CPPFLAGS} ${_LDFLAGS_GLOBAL} ${_LIBS_GLOBAL} ${LIBS}"

  make --directory="${_BLDDIR}" --jobs="${_JOBS}" install "DESTDIR=$(pwd)/${_PKGDIR}"

  _pkg="${_PP}"  # DESTDIR= + _PREFIX

  # Make steps for determinism

  readonly _ref='ChangeLog'

  "${_STRIP}" --enable-deterministic-archives --strip-debug "${_pkg}"/lib/*.a

  touch -c -r "${_ref}" "${_pkg}"/include/libssh/*.h
  touch -c -r "${_ref}" "${_pkg}"/lib/*.a

  # Create package

  _OUT="${_NAM}-${_VER}${_REVSUFFIX}${_PKGSUFFIX}"
  _BAS="${_NAM}-${_VER}${_PKGSUFFIX}"
  _DST="$(mktemp -d)/${_BAS}"

  mkdir -p "${_DST}/include/libssh"
  mkdir -p "${_DST}/lib"

  cp -f -p "${_pkg}"/include/libssh/*.h "${_DST}/include/libssh/"
  cp -f -p "${_pkg}"/lib/*.a            "${_DST}/lib/"
  cp -f -p ChangeLog                    "${_DST}/ChangeLog.txt"
  cp -f -p AUTHORS                      "${_DST}/AUTHORS.txt"
  cp -f -p COPYING                      "${_DST}/COPYING.txt"
  cp -f -p README                       "${_DST}/README.txt"

  ../_pkg.sh "$(pwd)/${_ref}"
)