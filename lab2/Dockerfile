FROM alpine:latest

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && mkdir -p /shared

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
