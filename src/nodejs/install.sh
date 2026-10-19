#!/usr/bin/env bash

PACKAGE_MANAGER="${PM:-"npm"}"

set -e

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo "Installing Node.js..."
dnf --assumeyes install nodejs
node --version

echo "Installing selected package manager..."
case "${PACKAGE_MANAGER}" in
  npm)
    dnf --assumeyes install nodejs-npm
    npm --version
    ;;
  pnpm)
    dnf --assumeyes install pnpm
    pnpm --version
    ;;
  yarn)
    dnf --assumeyes install yarnpkg
    yarn --version
    ;;
esac

echo "Done!"
