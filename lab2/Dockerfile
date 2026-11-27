FROM alpine:latest

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && mkdir -p /shared && command -v flock >/dev/null

VOLUME /shared

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
