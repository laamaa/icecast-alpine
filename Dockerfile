FROM alpine:latest

# Install icecast and required packages
RUN apk add --no-cache \
    icecast \
    su-exec

# Create icecast user and group
RUN addgroup -g 1000 -S icecast && \
    adduser -u 1000 -S -G icecast -s /bin/false -H icecast

# Create necessary directories
RUN mkdir -p /var/log/icecast2 /var/lib/icecast2 /etc/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2 /var/lib/icecast2 /etc/icecast2

# Copy default configuration if not provided via volume
COPY --chown=icecast:icecast config/icecast.xml /etc/icecast2/icecast.xml

# Expose the default Icecast port
EXPOSE 8000

# Start icecast server using su-exec to drop privileges
CMD ["su-exec", "icecast:icecast", "icecast2", "-c", "/etc/icecast2/icecast.xml"]