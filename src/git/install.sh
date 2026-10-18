#!/usr/bin/env bash

set -e

echo "Installing Git..."
dnf --assumeyes install git-core
git --version

echo "Done!"
