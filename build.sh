#!/bin/bash

docker volume create dd-agent-omnibus
docker volume create dd-agent-gems

docker run \
    -v "$(pwd):/go/src/github.com/DataDog/datadog-agent" \
    -v "dd-agent-omnibus:/omnibus" \
    -v "dd-agent-gems:/gems" \
    -v "/tmp/opt/datadog-agent:/opt/datadog-agent" \
    --workdir /go/src/github.com/DataDog/datadog-agent \
    datadog/agent-buildimages-rpm_x64 inv -e agent.omnibus-build --base-dir=/omnibus --gem-path=/gems

echo "Build output is in: $(pwd)/omnibus/pkg/"
