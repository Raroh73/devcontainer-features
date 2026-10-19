#!/usr/bin/env bash

set -e

ZIM="${ZIM:-"true"}"

source /etc/os-release

if [ "$(id --user)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

case "${ID}" in
  fedora)
    INSTALL_ZSH=(dnf --assumeyes install which zsh)
    ;;
  *)
    echo "${NAME} currently is not supported."
    exit 1
    ;;
esac

echo "Installing Zsh..."
"${INSTALL_ZSH[@]}"
zsh --version

echo "Changing shell..."
usermod --shell "$(which zsh)" "$_REMOTE_USER"

if [ "${ZIM}" = "true" ]; then
  echo "Installing Zim..."
  install --mode 644 --owner "$_REMOTE_USER" --group "$_REMOTE_USER" "$(dirname "$0")/zshrc.template" "$_REMOTE_USER_HOME/.zshrc"
  install --mode 644 --owner "$_REMOTE_USER" --group "$_REMOTE_USER" "$(dirname "$0")/zimrc.template" "$_REMOTE_USER_HOME/.zimrc"
  su "$_REMOTE_USER" --command 'zsh --interactive -c "zimfw --version"'
fi

echo "Done!"
