#!/bin/bash
docker rm alirootbuilder &>/dev/null
docker build --tag alirootbuilder:0.1 --tag alirootbuilder:latest --build-arg XRD_VER="4.6.1" --build-arg ADDITIONAL_VERSION_STRING="-gsi-2" .
docker run -v $PWD/build:/xrdinstall/vol  -i -t alirootbuilder:latest
