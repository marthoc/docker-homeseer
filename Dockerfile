FROM mono:5

ENV TINI_VERSION=0.17.0
ENV LANG=en_US.UTF-8
ENV HOMESEER_VERSION=3_0_0_368

RUN apt-get update && apt-get install -y \
    chromium \
    flite \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY start.sh /
RUN touch /DO_INSTALL

VOLUME [ "/HomeSeer" ] 
EXPOSE 80 10200 10300 10401 

ENTRYPOINT [ "/tini", "--", "/start.sh" ]