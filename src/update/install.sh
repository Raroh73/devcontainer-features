#!/usr/bin/env bash

set -e

source /etc/os-release

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

case "${ID}" in
  fedora)
    UPDATE_PACKAGES=(dnf --assumeyes update)
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Updating Dev Container..."
"${UPDATE_PACKAGES[@]}"

echo "Done!"
