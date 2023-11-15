FROM cloudfoundry/cli:latest

ADD entrypoint.sh /entrypoint.sh

RUN apk update
RUN apk upgrade
RUN apk add bash

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
