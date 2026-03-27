# Specify a different Prometheus version as needed
ARG PROMETHEUS_VERSION=2.52.0

# Use the official Prometheus base image
FROM prom/prometheus:v${PROMETHEUS_VERSION}

# Apply this repo's prometheus.yml file
ADD prometheus.yml /etc/prometheus/

# Storage and retention configuration for 1GB disk
# --storage.tsdb.retention.size=800MB keeps ~200MB headroom for compaction
# --storage.tsdb.wal-compression reduces WAL disk usage
CMD [ "--storage.tsdb.path=/var/data/prometheus", \
      "--storage.tsdb.retention.time=7d", \
      "--storage.tsdb.retention.size=800MB", \
      "--storage.tsdb.wal-compression", \
      "--config.file=/etc/prometheus/prometheus.yml", \
      "--web.console.libraries=/usr/share/prometheus/console_libraries", \
      "--web.console.templates=/usr/share/prometheus/consoles", \
      "--web.enable-remote-write-receiver" ]
