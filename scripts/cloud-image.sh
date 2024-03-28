#!/usr/bin/env bash

set -eux

# external variables that must be set
echo vars: $ARCH

# switch to dist dir
SCRIPT_DIR=$(realpath "$(dirname "$(dirname $0)")")
DIST_DIR="${SCRIPT_DIR}/dist/img"
mkdir -p $DIST_DIR

cd $DIST_DIR

download() (
    FILE="debian-${UBUNTU_VERSION}-genericcloud-${1}-daily"
    URL="https://cloud.debian.org/images/cloud/${UBUNTU_CODENAME}/daily/latest/${FILE}.tar.xz"
    curl -LO $URL
    tar -xf "${FILE}.tar.xz"
    mv disk.raw "${FILE}.raw"
    rm "${FILE}.tar.xz"

    shasum -a 512 "${FILE}" >"${FILE}.sha512sum"
)

# download
download $ARCH

# validate
# (
#     curl -sL https://cloud.debian.org/images/cloud/${UBUNTU_CODENAME}/daily/latest/SHA512SUMS | grep "genericcloud-arm64-daily.raw$" | shasum -a 512 --check --status
# )

echo download successful
ls -lh .
