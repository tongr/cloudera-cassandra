#!/usr/bin/env bash

if [ "$1" = "" ]; then
    echo "Usage: $0 <VERSION> [PARCEL_URL]"
    echo
    echo "Example: $0 1.0"
    exit 1
fi

set -ex

JARNAME=CASSANDRA-$1.jar


if [ -z "$2" ]; then
  CSD_SRC="./csd-src"
else
  # add parcel url to service description
  URL="$2"
  CSD_SRC="./csd-src-tmp"
  rm -rf "$CSD_SRC"
  cp -r "./csd-src" "$CSD_SRC"
  sed -ie "s|\"parcel\" : {|\"parcel\" :\n   {\n   \t\t\"repoUrl\" : \"$URL\",|" "$CSD_SRC/descriptor/service.sdl"
fi

# validate service description
java -jar cm_ext/validator/target/validator.jar -s "$CSD_SRC/descriptor/service.sdl"

mkdir -p ./parcel-and-csd
jar -cvf ./parcel-and-csd/$JARNAME -C "$CSD_SRC" .
echo "Created $JARNAME"
