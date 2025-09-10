# Use Alpine as base
FROM alpine:latest

# Install icecast and clean up
RUN apk add --no-cache icecast

# Copy a default config or mount one at runtime
# By default, Icecast config is at /etc/icecast/icecast.xml
COPY config/icecast.xml /etc/icecast.xml

# Expose Icecast web/streaming port
EXPOSE 8000

# Run as non-root user (optional, for better security)
USER icecast

# Start icecast with config
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
