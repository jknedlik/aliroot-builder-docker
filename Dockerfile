# -*- docker-image-name: "xrootd_base" -*-
# xrootd base image. Provides the base image for each xrootd service
FROM debian:8.8
MAINTAINER jknedlik <j.knedlik@gsi.de>
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN mkdir alice
RUN apt-get install -y curl build-essential gfortran subversion cmake libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libssl-dev libxml2-dev libtool automake git unzip libcgal-dev python-pip python-dev python-yaml environment-modules libperl-dev libncurses5-dev bzip2 libbz2-dev flex bison tcl8.6-dev autoconf autopoint libtool-bin libxft-dev libxml2-dev libxpm-dev swig texinfo xserver-xorg-dev libcurl4-openssl-dev
RUN cd alice && git clone https://github.com/alisw/alibuild.git
RUN ls -la
RUN cd alice && git clone https://github.com/graffaele/alidist -b master
RUN cd alice && git clone http://github.com/alisw/AliRoot
RUN pip install --user mock==1.0.0 numpy==1.9.2 certifi==2015.9.6.2 ipython==5.1.0 ipywidgets==5.2.2 ipykernel==4.5.0 notebook==4.2.3 metakernel==0.14.0 pyyaml
#RUN cd alice && git clone https://github.com/xrootd/xrootd.git -b stable-4.7.x
#RUN mkdir alice/xrdbuild && cd alice/xrdbuild && cmake ../xrootd && make -j8 install
RUN cd alice && alibuild/aliBuild  --disable DPMJET -j8 build AliRoot
RUN apt-get install -y lsb-release bzip2
RUN cd alice && curl http://alien.cern.ch/alien-installer -o ./alien-installer && chmod +x ./alien-installer
RUN cd alice && ./alien-installer -install-dir alien -notorrent -no-certificate-check
RUN echo "export LD_LIBRARY_PATH=/alice/alien/api/lib" >> /root/.bashrc
RUN echo "export PATH=/alice/alien/api/bin:$PATH" >> /root/.bashrc
COPY globus /root/.globus
