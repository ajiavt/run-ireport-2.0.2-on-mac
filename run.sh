#!/bin/bash

# Check if XQuartz is running
if ! pgrep -x "XQuartz" > /dev/null; then
    echo "Warning: XQuartz doesn't appear to be running."
    echo "Please start XQuartz and ensure 'Allow connections from network clients' is enabled in Security preferences."
    echo ""
fi

# Allow X11 forwarding for Docker
echo "Setting up X11 forwarding..."
xhost + 127.0.0.1

# Run iReport with proper display settings
echo "Starting iReport 2.0.2..."
docker run \
    --rm \
    --env DISPLAY=host.docker.internal:0 \
    --env QT_X11_NO_MITSHM=1 \
    --env NO_AT_BRIDGE=1 \
    --env LIBGL_ALWAYS_INDIRECT=1 \
    --env JAVA_TOOL_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true" \
    --hostname ireport \
    --volume "${PWD}/reports:/root/reports" \
    ireport:2.0.2

# Clean up X11 permissions
echo "Cleaning up X11 permissions..."
xhost - 127.0.0.1
