FROM mono:5

ENV TINI_VERSION=0.18.0
ENV LANG=en_US.UTF-8
ENV HOMESEER_VERSION=3_0_0_435
ENV ZEROCONF_ENABLED=NO

RUN apt-get update && apt-get install -y \
    chromium \
    flite \
    wget \
    avahi-daemon \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY start.sh /
RUN touch /DO_INSTALL

VOLUME [ "/HomeSeer" ] 
EXPOSE 80 10200 10300 10401 

ENTRYPOINT [ "/tini", "--", "/start.sh" ]
