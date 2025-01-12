FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine318

# title
ENV TITLE=Chromium

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    chromium \
    musl-locales \
    lang \
    font-noto-cjk \
    ca-certificates \
    wget && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-bin-2.35-r1.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-i18n-2.35-r1.apk && \
    apk --no-cache --force-overwrite add glibc-bin-2.35-r1.apk glibc-i18n-2.35-r1.apk glibc-2.35-r1.apk

RUN /usr/glibc-compat/bin/localedef -i zh_TW -f UTF-8 zh_TW.UTF-8

ENV LANG=zh_TW.UTF-8
ENV LANGUAGE=zh_TW
ENV TZ=Asia/Taipei

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
