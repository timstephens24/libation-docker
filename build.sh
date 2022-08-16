#!/bin/bash

if [ "$#" -ne 1 ]; then
        echo "Usage: build.sh <libation-zip>"
        exit 1
fi

LIBATION_ZIP=$1

rm -rf .build
mkdir .build

unzip -a -d .build ${LIBATION_ZIP}

# Make binaries executable
chmod +x .build/LibationCli
#chmod +x .build/Libation

# Parse version out of zip name
VERSION=$(echo ${LIBATION_ZIP} | cut -d'-' -f1 | cut -d'.' -f2-)

docker build -t pixil/libation:${VERSION} -t pixil/libation:latest --build-arg FOLDER_NAME=".build" .
