FROM registry.access.redhat.com/ubi10/ubi:latest

# Install EPEL and required packages
RUN dnf install -y epel-release && \
    dnf install -y \
    icecast \
    && dnf clean all

# Create icecast user and group
RUN groupadd -g 1000 icecast && \
    useradd -u 1000 -g icecast -s /bin/false -M icecast

# Create necessary directories
RUN mkdir -p /var/log/icecast2 /var/lib/icecast2 /etc/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2 /var/lib/icecast2 /etc/icecast2

# Copy default configuration if not provided via volume
COPY --chown=icecast:icecast config/icecast.xml /etc/icecast2/icecast.xml

# Expose the default Icecast port
EXPOSE 8000

# Switch to icecast user
USER icecast

# Set the working directory
WORKDIR /etc/icecast2

# Start icecast server
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]