#!/bin/bash
docker run --rm  -v"$PWD:/work" \
  -v"$PWD/.github/ct.yaml:/etc/ct/ct.yaml" \
  -w"/work" \
  quay.io/helmpack/chart-testing:v3.0.0-rc.1 $@
