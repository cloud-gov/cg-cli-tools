FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y curl && \
    curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar xzv -C /usr/local/bin cf && \
    cf install-plugin autopilot -f -r CF-Community

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]