FROM cloudfoundry/cli:7
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]