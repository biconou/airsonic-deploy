FROM ubuntu

LABEL description="Airsonic is a free, web-based media streamer, providing ubiquitious access to your music." \
      url="https://github.com/airsonic/airsonic"

ENV AIRSONIC_PORT=4040 AIRSONIC_DIR=/airsonic CONTEXT_PATH=/ UPNP_PORT=4041 JVM_HEAP=256m

WORKDIR $AIRSONIC_DIR

RUN apt-get update; apt-get install -y \
    ffmpeg \
    lame \
    bash \
    locales \
    # libressl \
    fontconfig \
    ttf-dejavu \
    ca-certificates \
    tini \
    openjdk-11-jdk-headless

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

COPY target/dependency/airsonic-10.6.2.war airsonic.war
COPY airsonic.properties data/airsonic.properties
#https://www.elastic.co/guide/en/apm/agent/java/1.x/setup-javaagent.html
COPY elastic-apm-agent-1.18.0.RC1.jar elastic-apm-agent-1.18.0.RC1.jar

# Set the locale
RUN sed -i '/fr_FR.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

EXPOSE $AIRSONIC_PORT

# Default DLNA/UPnP ports
EXPOSE $UPNP_PORT
EXPOSE 1900/udp

VOLUME $AIRSONIC_DIR/data $AIRSONIC_DIR/music $AIRSONIC_DIR/playlists $AIRSONIC_DIR/podcasts

HEALTHCHECK --interval=15s --timeout=3s CMD wget -q http://localhost:"$AIRSONIC_PORT""$CONTEXT_PATH"rest/ping -O /dev/null || exit 1

ENTRYPOINT ["tini", "--", "run.sh"]
