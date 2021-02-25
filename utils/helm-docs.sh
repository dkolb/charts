#!/bin/sh
docker run --rm -v $(pwd):/helm-docs -u $(id -u) jnorwood/helm-docs:latest
