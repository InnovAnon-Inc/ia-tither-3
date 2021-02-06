#! /bin/bash
set -euvxo pipefail
(( $# == 1 ))
[[ -n "$1" ]]

export CPPFLAGS="-DNDEBUG $CPPFLAGS"

if (( $1 == 1 )) ; then
  sleep 91
  git clone --depth=1 --recursive -b OpenSSL_1_1_1i https://github.com/openssl/openssl.git ||
fi
cd                           openssl
./Configure --prefix=$PREFIX                      \
	no-afalgeng                                   \
        no-async                                      \
        no-autoalginit                                \
	no-autoerrinit                                \
	no-bf                                         \
        no-blake2                                     \
        no-camellia                                   \
        no-capieng                                    \
        no-cast                                       \
        no-chacha                                     \
	no-cmac                                       \
        no-cms                                        \
        no-comp                                       \
        no-crypto-mdebug                              \
        no-crypto-mdebug-backtrace                    \
	no-ct                                         \
	no-deprecated                                 \
        no-des                                        \
	no-dgram                                      \
        no-dsa                                        \
        no-dso                                        \
        no-dtls                                       \
	no-dtls1                                      \
        no-dtls1-method                               \
	no-dynamic-engine                             \
        no-egd                                        \
        no-err                                        \
	no-gost                                       \
	no-heartbeats                                 \
        no-hw                                         \
        no-hw-padlock                                 \
        no-idea                                       \
        no-md2                                        \
        no-md4                                        \
	no-mdc2                                       \
        no-multiblock                                 \
	no-nextprotoneg                               \
        no-ocb                                        \
        no-ocsp                                       \
	no-poly1305                                   \
	no-posix-io                                   \
        no-psk                                        \
        no-rc2                                        \
	no-rc4                                        \
        no-rc5                                        \
        no-rdrand                                     \
        no-rfc3779                                    \
	no-rmd160                                     \
	no-scrypt                                     \
        no-sctp                                       \
        no-seed                                       \
        no-srp                                        \
        no-srtp                                       \
        no-ssl-trace                                  \
        no-ssl2                                       \
	no-ssl3                                       \
	no-ssl3-method                                \
        no-tls                                        \
	no-tls1                                       \
        no-tls1-method                                \
        no-ts                                         \
        no-ui                                         \
	no-unit-test                                  \
	no-weak-ssl-ciphers                           \
        no-whirlpool                                  \
        threads no-shared zlib                        \
	-static                                       \
        -DOPENSSL_SMALL_FOOTPRINT                     \
        -DOPENSSL_USE_IPV6=0                          \
        linux-x86_64
make
make install
if (( $1 == 1 )) ; then
  git reset --hard
  git clean -fdx
  git clean -fdx
fi
cd ..
if (( $1 == 2 )) ; then
  rm -rf openssl
  rm -v "$0"
fi

