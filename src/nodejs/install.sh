#!/usr/bin/env bash

PACKAGE_MANAGER="${PM:-"npm"}"

set -e

echo "Installing Node.js..."
dnf --assumeyes install nodejs
node --version

echo "Installing selected package manager..."
case "${PACKAGE_MANAGER}" in
  npm)
    dnf --assumeyes install nodejs-npm
    npm --version
    ;;
  nnpm)
    dnf --assumeyes install pnpm
    pnpm --version
    ;;
  yarn)
    dnf --assumeyes install yarnpkg
    yarn --version
    ;;
esac

echo "Done!"
