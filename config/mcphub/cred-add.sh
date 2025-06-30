#!/usr/bin/env bash

jq --arg key "$BRAVE_API_KEY" \
  '.mcpServers["brave-search"].env.BRAVE_API_KEY = $key' \
  "$HOME/dotfiles/config/mcphub/servers-no-creds.json" >"$HOME/.config/mcphub/servers.json"
