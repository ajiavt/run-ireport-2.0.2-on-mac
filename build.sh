#!/bin/bash

# Build iReport 2.0.2 Docker image
echo "Building iReport 2.0.2 Docker image..."
docker build -t ireport:2.0.2 .

echo "Build completed successfully!"
echo ""
echo "To run iReport 2.0.2, use:"
echo "docker run --rm --env DISPLAY=host.docker.internal:0 --hostname ireport --volume \${PWD}/reports:/root/reports ireport:2.0.2"
