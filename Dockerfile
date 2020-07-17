FROM ubuntu:latest
MAINTAINER Jack Lasseter jcklasseter@gmail.com
 
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y build-essential

#RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y git 
RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y git curl
RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y gfortran

WORKDIR /root

RUN curl https://www.mpich.org//static/downloads/3.3.2/mpich-3.3.2.tar.gz --output /root/mpich-3.3.2.tar.gz
#RUN cat mpich-3.3.2.tar.gz
RUN tar -zxvf /root/mpich-3.3.2.tar.gz
RUN mkdir mpich-install
RUN mkdir mpich-build
RUN cd mpich-build && ../mpich-3.3.2/configure -prefix=/root/mpich-install 
RUN cd mpich-build && make && make install
ENV PATH="/root/mpich-install/bin:${PATH}"

RUN git clone https://github.com/rouyang2017/SISSO.git

WORKDIR /root/SISSO

RUN cd src && mpifort -O2 var_global.f90 libsisso.f90 DI.f90 FC.f90 SISSO.f90 -o ~/SISSO.x

RUN mkdir /root/hostData
COPY entry.sh /root/
WORKDIR /root/hostData
ENTRYPOINT ["/bin/bash", "/root/entry.sh"]
