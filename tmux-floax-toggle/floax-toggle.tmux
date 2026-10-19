#!/usr/bin/env bash
# Toggle current pane in/out of floax scratch session.
# Option: @floax-toggle-key (default F)
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

key="$(tmux show-option -gqv @floax-toggle-key)"
key="${key:-F}"

tmux bind-key "$key" run-shell "'$CURRENT_DIR/scripts/toggle.sh' '#{pane_id}'"
