FROM itzg/minecraft-server
LABEL maintainer="Penn Labs"

ARG TOF_BUILDTOOLS_VER=1.2.0

ADD https://git.faldoria.de/tof/server/build-tools/-/jobs/artifacts/buildtools-${TOF_BUILDTOOLS_VER}/raw/target/ToF-BuildTools.jar?job=release-artifact /tmp/tof-buildtools/BuildTools.jar

ARG BUILDTOOLS_OUTPUT=/plugins
COPY plugins.yml /tmp/tof-buildtools/
RUN \
    [ -d /tmp/tof-buildtools ] && \
    [ $(find /tmp/tof-buildtools -type f -name plugins.yml | wc -l) -gt 0 ] && \
    java -jar /tmp/tof-buildtools/BuildTools.jar \
    --config "/tmp/tof-buildtools/plugins.yml" \
    --configs "plugins.yml" \
    --dir "/tmp/tof-buildtools/" \
    --output ${BUILDTOOLS_OUTPUT} && \
    chown -R minecraft:minecraft ${BUILDTOOLS_OUTPUT} && \
    rm -fR /tmp/tof-buildtools/ || \
    true

# Setting this server to spigot
ENV TYPE=SPIGOT
ENV VERSION="1.15.2"