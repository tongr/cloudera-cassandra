#!/usr/bin/env bash

if [ "$1" = "" -o "$2" = "" ]; then
    echo "Usage: $0 <VERSION> <DISTRO>"
    echo
    echo "Example: $0 1.0 el6"
    exit 1
fi

set -ex

PARCEL_DIR=$1
PARCEL=$PARCEL_DIR-$2.parcel
VERSION=$(echo $1 | sed -e 's/CASSANDRA-//g')

# Removing previously created parcel and manifest
rm -f parcel-and-csd/$PARCEL parcel-and-csd/manifest.json

# ADD CHECK ON PARCEL_DIR EXISTANCE!!!!!

cp -r parcel-src/meta $PARCEL_DIR/

sed -i -e "s/%VERSION%/$VERSION/" ./$PARCEL_DIR/meta/*

# Validate and build parcel
java -jar cm_ext/validator/target/validator.jar -d ./$PARCEL_DIR

tar zcvhf ./$PARCEL $PARCEL_DIR --owner=root --group=root

java -jar cm_ext/validator/target/validator.jar -f ./$PARCEL

# Remove parcel working directory
#rm -rf ./$PARCEL_DIR

# Create parcel manifest
python cm_ext/make_manifest/make_manifest.py .

mkdir -p parcel-and-csd/
mv manifest.json parcel-and-csd/
mv $PARCEL parcel-and-csd/
