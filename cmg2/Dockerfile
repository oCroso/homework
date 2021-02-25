FROM frolvlad/alpine-bash

COPY bootstrap.sh /
COPY example.log /
 
ENTRYPOINT ["/bin/bash", "/bootstrap.sh example.log"]
