#!/usr/bin/env bash

jq --arg key "$BRAVE_API_KEY" \
  '.mcpServers.brave-search.env.BRAVE_API_KEY = $key' \
  "$CWD/config/mcphub/servers-no-creds.json" >"$HOME/.config/mcphub/servers.json"
