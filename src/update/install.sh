#!/usr/bin/env bash

set -euo pipefail

source /etc/os-release

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

case "${ID}" in
  debian)
    UPDATE_PACKAGES="apt-get update && apt-get upgrade --assume-yes --no-install-recommends && apt-get clean"
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Updating Dev Container..."
eval "$UPDATE_PACKAGES"

echo "Done!"
