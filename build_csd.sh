#!/usr/bin/env bash

if [ "$1" = "" ]; then
    echo "Usage: $0 <VERSION>"
    echo
    echo "Example: $0 1.0"
    exit 1
fi

set -ex

JARNAME=LIVY-$1.jar
CSD_DIR=csd-build

[ ! -d ./$CSD_DIR ] && rm -rf ./$CSD_DIR

mkdir -p ./$CSD_DIR
cp -r ./csd-src/* ./$CSD_DIR

sed -i -e "s/%VERSION%/$1/" ./$CSD_DIR/descriptor/*

# validate service description
java -jar ../cm_ext/validator/target/validator.jar -s ./$CSD_DIR/descriptor/service.sdl

jar -cvf ./$JARNAME -C ./$CSD_DIR .
echo "Created $JARNAME"
