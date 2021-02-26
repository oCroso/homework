FROM alpine:latest

COPY entrypoint.sh /
RUN apk update && apk add bash curl jq gawk
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
