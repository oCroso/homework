FROM debian:latest

COPY entrypoint.sh /
RUN apt update && apt install curl gawk -y
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
