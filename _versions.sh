#!/bin/sh

# Copyright (C) Viktor Szakats. See LICENSE.md
# SPDX-License-Identifier: MIT

# NOTE: Bump nghttp3 and ngtcp2 together with curl.

export DOCKER_IMAGE='debian:testing-20230725-slim'

export CURL_VER_='8.2.1'
export CURL_HASH=dd322f6bd0a20e6cebdfd388f69e98c3d183bed792cf4713c8a7ef498cba4894
# Create revision string
# NOTE: Set _REV to 1 after bumping CURL_VER_, then increment for each
#       CI rebuild via `main` branch push (e.g. after bumping a dependency).
export _REV="${CW_REVISION:-1}"

export CACERT_VER_='2023-05-30'
export CACERT_HASH=5fadcae90aa4ae041150f8e2d26c37d980522cdb49f923fc1e1b5eb8d74e71ad
export BROTLI_VER_='1.0.9'
export BROTLI_HASH=f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46
export CARES_VER_='1.19.1'
export CARES_HASH=321700399b72ed0e037d0074c629e7741f6b2ec2dda92956abe3e9671d3e268e
export GSASL_VER_='2.2.0'
export GSASL_HASH=79b868e3b9976dc484d59b29ca0ae8897be96ce4d36d32aed5d935a7a3307759
export LIBUNISTRING_VER_='1.1'
export LIBUNISTRING_HASH=827c1eb9cb6e7c738b171745dac0888aa58c5924df2e59239318383de0729b98
export LIBICONV_VER_='1.17'
export LIBICONV_HASH=8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313
export LIBIDN2_VER_='2.3.4'
export LIBIDN2_HASH=93caba72b4e051d1f8d4f5a076ab63c99b77faee019b72b9783b267986dbb45f
export LIBPSL_VER_='0.21.2'
export LIBPSL_HASH=e35991b6e17001afa2c0ca3b10c357650602b92596209b7492802f3768a6285f
export WOLFSSH_VER_='1.4.13'
export WOLFSSH_HASH=95de536d2390ca4a8a7f9be4b2faaaebb61dcedf2c6571107172d4a64347421c
export LIBSSH_VER_='0.10.5'
export LIBSSH_HASH=b60e2ff7f367b9eee2b5634d3a63303ddfede0e6a18dfca88c44a8770e7e4234
export LIBSSH2_VER_='1.11.0'
export LIBSSH2_HASH=a488a22625296342ddae862de1d59633e6d446eff8417398e06674a49be3d7c2
export NGHTTP2_VER_='1.55.1'
export NGHTTP2_HASH=19490b7c8c2ded1cf7c3e3a54ef4304e3a7876ae2d950d60a81d0dc6053be419
export NGHTTP3_VER_='0.13.0'
export NGHTTP3_HASH=2b01b69c83f4506e7be3bc1a615b1818a92e762ec4be197a7931946e2ae005a0
export NGTCP2_VER_='0.17.0'
export NGTCP2_HASH=c652e44788c1cbab6f9bab0f38b139712ab25a6f9f8c4287e409f1e1f30ec441
export WOLFSSL_VER_='5.6.3'
export WOLFSSL_HASH=2e74a397fa797c2902d7467d500de904907666afb4ff80f6464f6efd5afb114a
export MBEDTLS_VER_='3.4.0'
export MBEDTLS_HASH=1b899f355022e8d02c4d313196a0a16af86c5a692456fa99d302915b8cf0320a
export QUICTLS_VER_='3.1.0'
export QUICTLS_HASH=4e356a49891adbbd74f88af065a52e151643737783874c888045ec1acf15d0ea
export OPENSSL_VER_='3.1.1'
export OPENSSL_HASH=b3aa61334233b852b63ddb048df181177c2c659eb9d4376008118f9c08d07674
export BORINGSSL_VER_='e4acd6cb568214b1c7db4e59ce54ea2e1deae1f5'
export BORINGSSL_HASH=559b0201111e89c503d79473611fbe0880d24dc4f2fbcc8306d78339a2a2b224
export LIBRESSL_VER_='3.8.0'
export LIBRESSL_HASH=12531c1ec808c5c6abeb311899664b0cfed04d4648f456dc959bb93c5f21acac
export ZLIBNG_VER_='2.1.3'
export ZLIBNG_HASH=d20e55f89d71991c59f1c5ad1ef944815e5850526c0d9cd8e504eaed5b24491a
export ZLIB_VER_='1.2.13'
export ZLIB_HASH=d14c38e313afc35a9a8760dadf26042f51ea0f5d154b0630a31da0540107fb98
export ZSTD_VER_='1.5.5'
export ZSTD_HASH=9c4396cc829cfae319a6e2615202e82aad41372073482fce286fac78646d3ee4
export LLVM_MINGW_LINUX_VER_='20230614'
export LLVM_MINGW_LINUX_HASH=9ae925f9b205a92318010a396170e69f74be179ff549200e8122d3845ca243b8
export LLVM_MINGW_MAC_VER_='20230614'
export LLVM_MINGW_MAC_HASH=e576b9a8121dc90332874c8ef7c9973cde6695de3a43d1dfb912fe8cc878722b
export LLVM_MINGW_WIN_VER_='20230614'
export LLVM_MINGW_WIN_HASH=94bc977c32cc70105d09dfa24d747effe187244ecd2aa669d50b69602a245236
