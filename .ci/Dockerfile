FROM jnovack/autossh:2.0.1 AS CLIENT
FROM panubo/sshd
ENV SSH_ENABLE_ROOT=true \
    GATEWAY_PORTS=true \
    TCP_FORWARDING=true \
    DISABLE_SFTP=true \
    SCP_MODE=false \
    RSYNC_MODE=false \
    MOTD="sshd ok"
EXPOSE 80
COPY /app /app/
WORKDIR /app
COPY --from=CLIENT /entrypoint.sh /app/client-entrypoint.sh
COPY --from=CLIENT /version.sh /app/
COPY --from=CLIENT /usr/bin/autossh /usr/bin/dumb-init /usr/bin/
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["server"]
