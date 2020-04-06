FROM ubuntu:latest

RUN apt-get update -y 
RUN apt-get install -y wget gnupg2
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -
RUN echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update -y 
RUN apt-get install cf-cli -y

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]