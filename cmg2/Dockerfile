FROM frolvlad/alpine-bash

COPY bootstrap.sh /
RUN apt update && apt install curl
ENTRYPOINT ["/bin/bash", "/bootstrap.sh"]
