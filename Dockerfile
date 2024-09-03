# Use the latest Debian base image
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99

# Install necessary packages
RUN apt-get update && apt-get install -y \
    qemu-system \
    xvfb \
    x11-xserver-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a script to start Xvfb and QEMU
RUN echo '#!/bin/bash\n' \
    'Xvfb :99 -screen 0 1024x768x16 &\n' \
    'sleep 2\n' \
    'qemu-system-x86_64 -M pc -accel tcg -m 16G -nographic -cdrom Porteus-LXDE-v5.01-x86_64.iso -vga virtio -display :99' \
    > /start.sh && chmod +x /start.sh

# Expose any necessary ports (if needed)
# EXPOSE 8080

# Set the command to run the script
CMD ["/start.sh"]
