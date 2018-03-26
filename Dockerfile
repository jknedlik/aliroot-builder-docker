# -*- docker-image-name: "xrootd_base" -*-
# xrootd base image. Provides the base image for each xrootd service
FROM debian:8.8
MAINTAINER jknedlik <j.knedlik@gsi.de>
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN mkdir alice
RUN apt-get install -y curl build-essential gfortran subversion cmake libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libssl-dev libxml2-dev libtool automake git unzip libcgal-dev python-pip python-dev python-yaml environment-modules libperl-dev libncurses5-dev bzip2 libbz2-dev flex bison tcl8.6-dev autoconf autopoint libtool-bin libxft-dev libxml2-dev libxpm-dev swig texinfo xserver-xorg-dev libcurl4-openssl-dev
RUN cd alice && git clone https://github.com/alisw/alibuild.git
RUN cd alice && git clone https://github.com/graffaele/alidist -b XRootD-pre-4.8
RUN cd alice && git clone http://github.com/alisw/AliRoot
RUN pip install --user mock==1.0.0 numpy==1.9.2 certifi==2015.9.6.2 ipython==5.1.0 ipywidgets==5.2.2 ipykernel==4.5.0 notebook==4.2.3 metakernel==0.14.0 pyyaml
RUN apt-get install -y tar
#debian 8.8 fix
COPY six-1.11.0 /six
RUN cd /six && python2 setup.py install
# init root in dev mode
RUN cd alice && alibuild/aliBuild init ROOT
# build ALiRoot's ROOT
RUN cd alice && alibuild/aliBuild  --disable DPMJET --disable GMP --disable Vc  --disable MPFR -j8 build ROOT --debug
COPY globus /root/.globus
