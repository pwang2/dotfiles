# Issues - Update Neovim Dashboard

## Problems Encountered

## Solutions Applied
## Issues Encountered

### [2026-01-27 17:00] Dashboard Header Format Error

**Error Message**:
```
Error executing lua callback: .../snacks.nvim/lua/snacks/dashboard.lua:488: attempt to call a nil value
stack traceback:
  .../snacks.nvim/lua/snacks/dashboard.lua:488: in function 'resolve'
```

**Root Cause**:
- Initial implementation used inline `text` array with highlight tuples in the header section
- Snacks.nvim dashboard expects header to be defined in `preset.header` as a string
- Header section then uses a `formats.header` function to render and apply highlights
- The inline approach bypassed the normal rendering pipeline causing nil value errors

**Wrong Approach**:
```lua
sections = {
  {
    section = "header",
    text = {
      { "line1", hl = "SnacksDashboardHeader1" },
      { "line2", hl = "SnacksDashboardHeader2" },
      -- ...
    },
  },
}
```

**Correct Approach**:
```lua
preset = {
  header = [[
line1
line2
line3]],
},
formats = {
  header = function(item)
    local lines = vim.split(item, "\n")
    local result = {}
    local highlights = { "Header1", "Header2", "Header3" }
    for i, line in ipairs(lines) do
      table.insert(result, { line, hl = highlights[i], align = "center" })
    end
    return result
  end,
},
sections = {
  { section = "header" },
}
```

**Fix Applied**:
- Moved ASCII art to `preset.header` as multiline string
- Created custom `formats.header` function that:
  1. Splits header string into lines
  2. Maps each line to corresponding highlight group (Header1-6)
  3. Returns array of `{line, hl, align}` tuples
- Kept simple `{ section = "header" }` in sections array

**Verification**:
- ✅ Neovim starts without errors
- ✅ Dashboard loads successfully
- ✅ Header renders with gradient highlights (need visual confirmation)

**Commit**: `c7a8296` - fix(nvim): use correct snacks dashboard header format with gradient highlights

**Key Learning**:
- Snacks.nvim has a specific architecture: `preset` defines content, `formats` defines rendering, `sections` defines layout
- Cannot bypass the rendering pipeline with inline text/highlight definitions
- Always check plugin's default configuration structure before customizing
- The `formats` table is the proper place for custom rendering logic

