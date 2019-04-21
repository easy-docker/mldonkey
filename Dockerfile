FROM debian:jessie

RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y mldonkey-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/mldonkey && \
    rm /var/lib/mldonkey/* && \
    mkdir -p /temp && chmod 777 /temp && \
    mkdir -p /incoming && chmod 777 /incoming

USER mldonkey
ENV MLDONKEY_DIR=/var/lib/mldonkey LC_ALL=C.UTF-8 LANG=C.UTF-8
VOLUME /var/lib/mldonkey
VOLUME /incoming
EXPOSE 4001 4080 19040 19044
ADD entrypoint.sh /
CMD /entrypoint.sh
