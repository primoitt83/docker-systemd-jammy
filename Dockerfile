FROM ubuntu:jammy

RUN \
    apt update && \
    apt install -y systemd

## Cleanup
RUN \
    apt-get clean autoclean && \
    apt-get autoremove --yes

## command to init systemd
CMD ["/lib/systemd/systemd"]