#!/bin/bash
docker rm alirootbuilder &>/dev/null
docker build --tag alirootbuilder5:0.1 --tag alirootbuilder5:latest --build-arg XRD_VER="4.6.1" --build-arg ADDITIONAL_VERSION_STRING="-gsi-2" .
#docker run  -i -t alirootbuilder5:latest
