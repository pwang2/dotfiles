#!/usr/bin/env bash
# outside scratch: move pane into scratch, remember origin, pop it up at full height
# inside scratch: move pane back to its origin window at its old position and layout
#   (or a new window in origin session if that window is gone), close popup
pane="$1"
[ -n "$pane" ] || exit 1

info() { tmux display-message -p -t "$pane" "$1"; }
pane_opt() { tmux show-option -pqv -t "$pane" "$1"; }

session="$(info '#{session_name}')"

if [ "$session" = scratch ]; then
  win="$(pane_opt @floax-origin-window)"
  sess="$(pane_opt @floax-origin-session)"
  prev="$(pane_opt @floax-origin-prev)"
  next="$(pane_opt @floax-origin-next)"
  layout="$(pane_opt @floax-origin-layout)"
  cur_win="$(info '#{window_id}')"
  [ -n "$sess" ] || sess="$(tmux show-environment -g ORIGIN_SESSION | cut -d= -f2-)"
  for o in window session prev next layout; do tmux set-option -pu -t "$pane" "@floax-origin-$o"; done

  in_win() { [ -n "$1" ] && tmux list-panes -t "$win" -F '#{pane_id}' | grep -qx "$1"; }

  if [ -n "$win" ] && [ "$win" != "$cur_win" ] \
    && tmux list-windows -t "$sess" -F '#{window_id}' | grep -qx "$win"; then
    { in_win "$prev" && tmux join-pane -s "$pane" -t "$prev"; } ||
      { in_win "$next" && tmux join-pane -b -s "$pane" -t "$next"; } ||
      tmux join-pane -s "$pane" -t "$win"
    tmux select-layout -t "$win" "$layout" 2>/dev/null
    tmux select-window -t "$win"
  else
    tmux break-pane -s "$pane" -t "$sess:"
  fi
  tmux has-session -t scratch 2>/dev/null && tmux detach-client -s scratch
  exit 0
fi

tmux has-session -t scratch 2>/dev/null || {
  tmux new-session -d -s scratch -c "$(info '#{pane_current_path}')"
  tmux set-option -t scratch status off
}
tmux set-option -p -t "$pane" @floax-origin-window "$(info '#{window_id}')"
tmux set-option -p -t "$pane" @floax-origin-session "$session"
tmux set-option -p -t "$pane" @floax-origin-layout "$(info '#{window_layout}')"

prev= next= found=
for id in $(tmux list-panes -t "$(info '#{window_id}')" -F '#{pane_id}'); do
  if [ "$id" = "$pane" ]; then found=1
  elif [ -n "$found" ]; then next=$id; break
  else prev=$id; fi
done
tmux set-option -p -t "$pane" @floax-origin-prev "$prev"
tmux set-option -p -t "$pane" @floax-origin-next "$next"

w="$(tmux break-pane -d -P -F '#{window_id}' -s "$pane" -t scratch:)"
tmux select-window -t "$w"
tmux set-environment -g ORIGIN_SESSION "$session"
tmux set-option -t scratch detach-on-destroy on
tmux popup -b rounded -E -w "$(tmux show-environment -g FLOAX_WIDTH | cut -d= -f2-)" -h 100% \
  -S fg=magenta -s fg=blue -T " FloaX " "tmux attach-session -t scratch"
