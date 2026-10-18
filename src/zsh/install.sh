#!/usr/bin/env bash

ZIM="${ZIM:-"true"}"

set -e

echo "Installing Zsh..."
dnf --assumeyes install which zsh
zsh --version

echo "Changing shell..."
usermod --shell "$(which zsh)" "$_REMOTE_USER"

if [ "${ZIM}" = "true" ]; then
  echo "Installing Zim..."
  install --mode 644 --owner "$_REMOTE_USER" --group "$_REMOTE_USER" "$(dirname "$0")/zshrc.template" "$_REMOTE_USER_HOME/.zshrc"
  install --mode 644 --owner "$_REMOTE_USER" --group "$_REMOTE_USER" "$(dirname "$0")/zimrc.template" "$_REMOTE_USER_HOME/.zimrc"
  su "$_REMOTE_USER" --command 'zsh --command "zimfw --version"'
fi

echo "Done!"
