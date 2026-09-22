FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    lmodern \
    poppler-utils \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/compile.sh /usr/local/bin/compile
RUN chmod +x /usr/local/bin/compile

WORKDIR /workspace

ENTRYPOINT ["compile"]
CMD ["once"]
