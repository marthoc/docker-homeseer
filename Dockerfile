FROM debian:9-slim

ENV DEBIAN_FRONTEND noninteractive
ENV TINI_VERSION=0.16.1
ENV LANG=en_US.UTF-8
ENV HOMESEER_VERSION=3_0_0_368

RUN apt-get update && apt-get install -y \
    chromium \
    flite \
    libmono-system-data-datasetextensions4.0-cil \
    libmono-system-design4.0.cil \
    libmono-system-runtime-caching4.0-cil \
    libmono-system-web4.0.cil \
    libmono-system-web-extensions4.0-cil \
    mono-vbnc \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}-amd64.deb /
    
RUN dpkg -i /tini*.deb \
    && rm /tini*.deb

ADD run.sh /

RUN touch /DO_INSTALL

VOLUME [ "/HomeSeer" ] 

EXPOSE 80 10200 10300 10401 

ENTRYPOINT [ "tini", "--", "/run.sh" ]