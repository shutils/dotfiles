#!/usr/bin/env bash

set -u

if ! command -v fzf >/dev/null 2>&1; then
  printf 'fzf is required to use the Zellij palette.\n' >&2
  exit 1
fi

# CLI actions are not bound to ZELLIJ_ORIGIN_CLIENT_ID. Refuse multiple clients
# and, when provided, require the sole client to match the bridge's origin.
focused_pane() {
  local clients
  clients=$(zellij action list-clients) || return 1
  awk -v expected="${ZELLIJ_ORIGIN_CLIENT_ID:-}" '
    NR > 1 && NF >= 2 { count++; client = $1; pane = $2 }
    END {
      if (count == 1 && (expected == "" || client == expected)) print pane
      else exit 1
    }
  ' <<< "$clients"
}

floating() {
  local arg
  local -a width=(--width '80%') height=(--height '80%') pinned=(--pinned false)

  # Supply defaults only when the item does not specify its own options.
  for arg in "$@"; do
    case "$arg" in
      --) break ;;
      --width|--width=*) width=() ;;
      --height|--height=*) height=() ;;
      --pinned|--pinned=*) pinned=() ;;
    esac
  done

  exec zellij run --floating --close-on-exit --cwd "$PWD" \
    "${width[@]}" "${height[@]}" "${pinned[@]}" "$@"
}

run_floating_shell() {
  floating --name 'Floating shell' -- zsh -ic 'zsh -i'
}

run_lazygit() {
  floating --name lazygit -- zsh -ic 'lazygit'
}

run_lazydocker() {
  floating --name lazydocker -- zsh -ic 'lazydocker'
}

run_codex_usage() {
  floating --name 'Codex usage' --width '50%' --height '50%' -- zsh -ic \
    'codex-usage; printf "\nPress any key to close..."; read -k 1; printf "\n"'
}

run_opencode_ask() {
  floating --name OpenCode-Ask --width '30%' --height '100%' --x '70%' \
    -- zsh -ic 'opencode'
}

run_opencode_instant() {
  floating --name OpenCode-Instant --width '30%' --height '100%' --x '70%' \
    --pinned true -- zsh -ic 'opencode'
}

run_onefetch() {
  floating --name Onefetch -- zsh -ic \
    'onefetch; printf "\nPress any key to close..."; read -k 1; printf "\n"'
}

run_ssh() {
  floating --name SSH -- zsh -ic 'bash ~/.config/zellij/scripts/ssh_picker.sh'
}

split_pane() {
  local direction="$1" origin_pane="${ZELLIJ_ORIGIN_PANE_ID:-}"
  if [[ ! "$origin_pane" =~ ^(terminal|plugin)_[0-9]+$ ]]; then
    printf 'A valid ZELLIJ_ORIGIN_PANE_ID from zellij-context-bridge is required; no pane was created.\n' >&2
    exit 1
  fi
  if ! focused_pane >/dev/null; then
    printf 'Could not safely identify a single origin client; no pane was created.\n' >&2
    exit 1
  fi
  if ! zellij action focus-pane-id "$origin_pane" >/dev/null || [[ "$(focused_pane)" != "$origin_pane" ]]; then
    printf 'Could not focus the origin pane; no pane was created.\n' >&2
    exit 1
  fi
  # Focus and creation are separate CLI actions, not an atomic operation.
  exec zellij run --direction "$direction" --close-on-exit -- zsh -i
}

run_split_right() {
  split_pane right
}

run_split_down() {
  split_pane down
}

run_edit_zellij_config() {
  floating --name 'Edit Zellij config' -- zsh -ic 'vim ~/.config/zellij'
}

run_edit_current_directory() {
  floating --name 'Edit current directory' -- zsh -ic 'vim .'
}

# Display name | Function (listed in display order)
commands=(
  'Floating shell|run_floating_shell'
  'lazygit|run_lazygit'
  'lazydocker|run_lazydocker'
  'Codex usage|run_codex_usage'
  'OpenCode-Ask|run_opencode_ask'
  'OpenCode-Instant|run_opencode_instant'
  'Onefetch|run_onefetch'
  'SSH|run_ssh'
  'Split pane right|run_split_right'
  'Split pane down|run_split_down'
  'Edit Zellij config|run_edit_zellij_config'
  'Edit current directory|run_edit_current_directory'
)

selected=$(printf '%s\n' "${commands[@]}" | cut -d '|' -f 1 | fzf --prompt='Run command > ' --reverse) || exit 0

for entry in "${commands[@]}"; do
  if [[ "${entry%%|*}" == "$selected" ]]; then
    "${entry#*|}"
    exit "$?"
  fi
done
