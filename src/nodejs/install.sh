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
  debian)
    INSTALL_REQUIRED_PACKAGES="apt-get update && apt-get install --assume-yes --no-install-recommends curl && apt-get clean"
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Installing required packages..."
eval "$INSTALL_REQUIRED_PACKAGES"

echo "Installing NVM..."
su "$_REMOTE_USER" --command 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.41.0/install.sh | bash'
nvm --version

echo "Installing Node.js..."
nvm install "${NODEJS_VERSION}"
node --version

echo "Installing selected package manager..."
case "${PACKAGE_MANAGER}" in
  npm)
    npm --version
    ;;
  pnpm)
    npm install -g corepack
    corepack enable pnpm
    pnpm --version
    ;;
  yarn)
    npm install -g corepack
    corepack enable yarn
    yarn --version
    ;;
esac

echo "Done!"
