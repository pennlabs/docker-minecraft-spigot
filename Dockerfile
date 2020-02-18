FROM itzg/minecraft-server
LABEL maintainer="Penn Labs"

ARG SLACK_PATH="v2.0.0-alpha.1/slackmc-2.0.0-SNAPSHOT"

# Setting this server to spigot
ENV TYPE=SPIGOT

RUN apk update && \
    apk add --no-cache ca-certificates wget && \
    update-ca-certificates

RUN wget -P plugins/ https://github.com/mastercoms/SlackMC/releases/download/${SLACK_PATH}.jar
