#!/usr/bin/env bash

set -e

PACKAGE_MANAGER="${PM:-"npm"}"

source /etc/os-release

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

case "${ID}" in
  fedora)
    INSTALL_NODEJS=(dnf --assumeyes install nodejs)
    INSTALL_NPM=(dnf --assumeyes install nodejs-npm)
    INSTALL_PNPM=(dnf --assumeyes install pnpm)
    INSTALL_YARN=(dnf --assumeyes install yarnpkg)
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Installing Node.js..."
"${INSTALL_NODEJS[@]}"
node --version

echo "Installing selected package manager..."
case "${PACKAGE_MANAGER}" in
  npm)
    "${INSTALL_NPM[@]}"
    npm --version
    ;;
  pnpm)
    "${INSTALL_PNPM[@]}"
    pnpm --version
    ;;
  yarn)
    "${INSTALL_YARN[@]}"
    yarn --version
    ;;
esac

echo "Done!"
