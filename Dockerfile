FROM mono:latest

ENV TINI_VERSION=0.18.0
ENV LANG=en_US.UTF-8
ENV HOMESEER_VERSION=3_0_0_472

RUN apt-get update && apt-get install -y \
    chromium \
    flite \
    wget \
    nano \
    iputils-ping \
    mono-complete \
    mono-vbnc \
    mono-xsp4 \
    avahi-discover \
    libavahi-compat-libdnssd-dev \
    libnss-mdns \
    avahi-daemon avahi-utils mdns-scan \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY start.sh /
RUN touch /DO_INSTALL

VOLUME [ "/HomeSeer" ] 
EXPOSE 80 10200 10300 10401 

ENTRYPOINT [ "/tini", "--", "/start.sh" ]
