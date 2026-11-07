#!/usr/bin/env bash

set -u

config="$HOME/.ssh/config"
if [[ ! -r "$config" ]]; then
  printf 'SSH config not found: %s\n' "$config" >&2
  read -r -n 1 -p 'Press any key to close...'
  exit 1
fi

host=$(awk '
  tolower($1) == "host" {
    for (i = 2; i <= NF && $i !~ /^#/; i++) {
      if ($i !~ /[*?!]/) print $i
    }
  }
' "$config" | sort -u | fzf --prompt='SSH host > ' --reverse \
  --preview='ssh -G -- {} 2>/dev/null | awk '\''$1 ~ /^(hostname|user|port|identityfile|proxyjump|proxycommand|forwardagent)$/ {print}'\''' \
  --preview-window='right:50%:wrap') || exit 0

exec zellij action new-tab --name "SSH: $host" --close-on-exit -- ssh -- "$host"
