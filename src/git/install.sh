#!/usr/bin/env bash

set -e

echo "Installing Git..."
dnf --assumeyes install git
git --version

echo "Done!"
