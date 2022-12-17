#!/bin/bash

# Setting the variables
DOCKER_USER=timstephens24
LIBATION_RELEASE=$(curl -sX GET "https://api.github.com/repos/rmcrackan/libation/releases/latest" | jq -r .tag_name);
LIBATION_VERSION="$(echo ${LIBATION_RELEASE} | cut -c2-)"
LIBATION_DOCKER="$(docker manifest inspect ${DOCKER_USER}/libation:${LIBATION_VERSION})"
LIBATION_URL="https://github.com/rmcrackan/Libation/releases/download/${LIBATION_RELEASE}/Libation.${LIBATION_VERSION}-linux-chardonnay.zip"

# Test if version already exists
if [[ -z ${LIBATION_DOCKER} ]]; then
  echo "Missing this version. Updating latest and pushing the image for this release."
else
  echo "Already have this release. Quitting..."
  exit
fi

# Get the zip and set up the environment
curl -o libation.zip -L "$LIBATION_URL"
mkdir .build
unzip -a -d .build libation.zip
chmod +x .build/LibationCli

# Do the build and push it to docker hub
docker build -t ${DOCKER_USER}/libation:${LIBATION_VERSION} -t ${DOCKER_USER}/libation:latest --build-arg FOLDER_NAME=".build" .
docker push ${DOCKER_USER}/libation:${LIBATION_VERSION}
docker push ${DOCKER_USER}/libation:latest
docker rmi mcr.microsoft.com/dotnet/runtime:7.0
docker rmi ${DOCKER_USER}/libation:${LIBATION_VERSION}

# Remove the leftover files
rm -rf .build
rm libation.zip
