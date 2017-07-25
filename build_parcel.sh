#!/usr/bin/env bash

if [ "$1" = "" -o "$2" = "" ]; then
    echo "Usage: $0 <VERSION> <DISTRO>"
    echo
    echo "Example: $0 1.0 wheezy"
    exit 1
fi

set -ex

PARCEL_DIR=LIVY-$1
PARCEL=$PARCEL_DIR-$2.parcel

[ ! -d ./$PARCEL_DIR ] && rm -rf ./$PARCEL_DIR

mkdir -p ./$PARCEL_DIR

cp -r parcel-src/meta $PARCEL_DIR/

sed -i -e "s/%VERSION%/$1/" ./$PARCEL_DIR/meta/*

# Validate and build parcel
java -jar ~/github/cloudera/cm_ext/validator/target/validator.jar -d ./$PARCEL_DIR

tar zcvhf ./$PARCEL $PARCEL_DIR

java -jar ~/github/cloudera/cm_ext/validator/target/validator.jar -f ./$PARCEL

# Remove parcel working directory
rm -rf ./$PARCEL_DIR

# Create parcel manifest
~/github/cloudera/cm_ext/make_manifest/make_manifest.py .
