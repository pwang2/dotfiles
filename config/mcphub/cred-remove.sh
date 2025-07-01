#!/usr/bin/env bash
# this was setup in incrontab
jq '.mcpServers["brave-search"].env.BRAVE_API_KEY = ""' \
  "$HOME/.config/mcphub/servers.json" >"$CWD/config/mcphub/servers-no-creds.json"
