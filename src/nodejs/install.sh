#!/usr/bin/env bash

set -euo pipefail

NODEJS_VERSION="${NV:-"26"}"
PACKAGE_MANAGER="${PM:-"npm"}"

source /etc/os-release

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

case "${ID}" in
  fedora)
    INSTALL_NODEJS="dnf --assumeyes install nodejs${NODEJS_VERSION} && dnf clean all"
    INSTALL_NPM="dnf --assumeyes install nodejs-npm && dnf clean all"
    INSTALL_PNPM="dnf --assumeyes install pnpm && dnf clean all"
    INSTALL_YARN="dnf --assumeyes install yarnpkg && dnf clean all"
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Installing Node.js..."
eval "$INSTALL_NODEJS"
node --version

echo "Installing selected package manager..."
case "${PACKAGE_MANAGER}" in
  npm)
    eval "$INSTALL_NPM"
    npm --version
    ;;
  pnpm)
    eval "$INSTALL_PNPM"
    pnpm --version
    ;;
  yarn)
    eval "$INSTALL_YARN"
    yarn --version
    ;;
esac

echo "Done!"
