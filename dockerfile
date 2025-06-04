FROM ubuntu:24.04

ARG VERSION_TAG=2.8.8
WORKDIR /app

RUN apt-get update && apt-get install -y wget tar \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN VERSION_STRING=$(echo "$VERSION_TAG" | tr '.' '-') \
    && wget https://github.com/doktor83/SRBMiner-Multi/releases/download/${VERSION_TAG}/SRBMiner-Multi-${VERSION_STRING}-Linux.tar.gz \
    && tar -xzf SRBMiner-Multi-${VERSION_STRING}-Linux.tar.gz \
    && mv SRBMiner-Multi-${VERSION_STRING}/SRBMiner-MULTI . \
    && rm -rf SRBMiner-Multi-${VERSION_STRING}* SRBMiner-Multi-${VERSION_STRING}-Linux.tar.gz

RUN chmod +x SRBMiner-MULTI

COPY start_srbminer.sh .
RUN chmod +x start_srbminer.sh

ENTRYPOINT ["./start_srbminer.sh"]
