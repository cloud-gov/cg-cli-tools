FROM cloudfoundry/cli:8
RUN apk update && apk upgrade && apk add --no-cache bash jq curl grep coreutils
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
