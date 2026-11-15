#!/usr/bin/env bash

set -euo pipefail

source /etc/os-release

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

case "${ID}" in
  debian)
    INSTALL_SUDO="apt-get update && apt-get install --assume-yes --no-install-recommends sudo && apt-get clean"
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Installing Sudo..."
eval "$INSTALL_SUDO"
echo "$_REMOTE_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"$_REMOTE_USER"
chmod 0440 /etc/sudoers.d/"$_REMOTE_USER"

echo "Done!"
