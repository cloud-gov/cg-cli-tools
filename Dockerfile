FROM cloudfoundry/cli:8
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]