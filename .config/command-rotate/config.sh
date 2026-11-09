# Trusted Bash configuration. Changes take effect when command-rotate restarts.
ROTATE_INTERVAL=10
COMMAND_TIMEOUT=30

# add_command NAME REFRESH_INTERVAL_SECONDS SHELL_COMMAND
# Commands run in the directory where command-rotate was started.
# Add scripts to PATH or use absolute paths if your dotfiles live elsewhere.
add_command "Codex" 300 '"$HOME/dotfiles/scripts/codex-usage"'
add_command "Repositories" 60 '"$HOME/dotfiles/scripts/ghq-status"'

# add_command "Disk" 120 'df -h'
