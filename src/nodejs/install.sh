#!/usr/bin/env bash

PACKAGE_MANAGER="${PM:-"npm"}"

set -e

echo "Installing Node.js..."
dnf --assumeyes install nodejs
node --version

echo "Installing selected package manager..."
case "${PACKAGE_MANAGER}" in
  npm)
    dnf --assume-yes install nodejs-npm
    npm --version
    ;;
  nnpm)
    dnf --assume-yes install pnpm
    pnpm --version
    ;;
  yarn)
    dnf --assume-yes install yarnpkg
    yarn --version
    ;;
esac

echo "Done!"
