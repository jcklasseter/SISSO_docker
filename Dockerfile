FROM ubuntu:focal
MAINTAINER Jack Lasseter jcklasseter@gmail.com
 
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y build-essential

RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y git curl
RUN curl -Lo- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor -o /usr/share/keyrings/oneapi-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" > /etc/apt/sources.list.d/oneAPI.list
RUN apt update
RUN DEBIAN_FRONTEND='noninteractive' apt install -y intel-oneapi-compiler-fortran
RUN DEBIAN_FRONTEND='noninteractive' apt install -y intel-oneapi-mkl intel-oneapi-mpi-devel
SHELL ["/bin/bash", "-c"] 

RUN git clone https://github.com/rouyang2017/SISSO.git
WORKDIR /SISSO

RUN source /opt/intel/oneapi/setvars.sh && cd src && mpiifort -O2 var_global.f90 libsisso.f90 DI.f90 FC.f90 SISSO.f90 -o ~/SISSO.x

RUN mkdir /root/hostData
COPY entry.sh /root/
#\r ...
RUN sed -i 's/\r//g' /root/entry.sh
WORKDIR /root/hostData
ENTRYPOINT ["/bin/bash", "/root/entry.sh"]
