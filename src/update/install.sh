#!/usr/bin/env bash

set -e

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo "Updating Dev Container..."
dnf --assumeyes update

echo "Done!"
