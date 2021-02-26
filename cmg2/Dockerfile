FROM debian:latest

COPY entrypoint.sh /
RUN apt update && apt install jq curl gawk -y
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
