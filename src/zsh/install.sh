#!/usr/bin/env bash

set -e

echo "Installing Zsh..."
dnf install -y which zsh
zsh --version

echo "Changing shell..."
usermod --shell "$(which zsh)" "$_REMOTE_USER"

echo "Done!"
