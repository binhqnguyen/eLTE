FROM ubuntu:18.04

MAINTAINER BN

RUN apt-get update && \
    apt-get install -y cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev git

COPY srsLTE /opt/srsLTE
WORKDIR /opt/srsLTE


RUN mkdir build; \
    cd build; \ 
    cmake ../; \ 
    make && \
    #make test && \
    make install && \
    ./srslte_install_configs.sh service
     
CMD ["srsepc"]

