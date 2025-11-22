#!/bin/bash

set -e

# Select SDK based on SDK_TYPE environment variable
case "${SDK_TYPE,,}" in
    ps4|ps4-payload-sdk)
        echo "Using PS4 Payload SDK"
        export PS4_PAYLOAD_SDK=/opt/ps4-payload-sdk
        # Some projects may use generic SDK path
        export PAYLOAD_SDK=/opt/ps4-payload-sdk
        export SDK_PATH=/opt/ps4-payload-sdk
        ;;
    ps5|ps5-payload-sdk|*)
        echo "Using PS5 Payload SDK"
        export PS5_PAYLOAD_SDK=/opt/ps5-payload-sdk
        # Some projects may use generic SDK path
        export PAYLOAD_SDK=/opt/ps5-payload-sdk
        export SDK_PATH=/opt/ps5-payload-sdk
        ;;
esac

# Display SDK info
echo "SDK Path: ${SDK_PATH}"
echo "Working directory: $(pwd)"
echo "---"

# Execute the command passed to the container
exec "$@"
