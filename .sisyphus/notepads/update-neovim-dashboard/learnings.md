# Learnings - Update Neovim Dashboard

## Conventions & Patterns

### OpenSpec File Structure
- Changes go in `openspec/changes/[change-id]/` directory
- Three main files: `proposal.md`, `tasks.md`, and delta specs under `specs/`
- Spec files use `## ADDED|MODIFIED|REMOVED|RENAMED Requirements` headers
- Scenarios MUST use `#### Scenario: Name` format (4 hashtags, not bullets)

### Scenario Format Rules
- Each scenario is its own `#### Scenario:` header
- Contains `- **WHEN**` condition bullet
- Followed by `- **THEN**` expected result bullet
- Every requirement needs at least one scenario for validation to pass

## Gotchas

### Scenario Parsing
- Wrong: Using `- **Scenario: Name**` as bullet point
- Wrong: Using `### Scenario: Name` (3 hashtags)
- Right: Using `#### Scenario: Name` (4 hashtags) as a section header

### Validation
- `openspec validate` runs basic checks
- `openspec validate --strict` runs comprehensive checks including scenario format
- Both must pass before implementation begins

## Key Decisions

### Four Requirements in nvim-dashboard Spec
1. **Dashboard Header** - Gradient colors with theme adaptation (dark/light)
2. **Git Status Display** - Contextual display (hidden outside repos)
3. **Quick Actions** - 9 buttons with keybindings for common tasks
4. **Programming Quotes** - Rotating display on each startup

### Scope: New Capability
- This is a new feature, no existing specs affected
- Using `## ADDED Requirements` section exclusively
- No MODIFIED or REMOVED requirements needed

## Task 1: Dashboard Header Highlights Implementation

### Implementation Details
- Added 6 dashboard header color definitions to `dark_palette` (lines 85-90):
  - Colors range from blue (#61afef) → cyan → green → yellow → purple → red-pink
  - Bright colors optimized for dark backgrounds
  
- Added 6 dashboard header color definitions to `light_palette` (lines 165-170):
  - Colors use deeper versions (#2b6cb0 → #2c7a7b → etc.) for contrast on light backgrounds
  
- Added 6 highlight group definitions in `M.setup()` function (lines 201-206):
  - Groups: `SnacksDashboardHeader1` through `SnacksDashboardHeader6`
  - Each group sets foreground color only (`fg`), background to "NONE"
  - Automatically uses correct palette based on vim.o.background setting

### Pattern Followed
- Color definitions stored in palette tables (dark_palette and light_palette)
- Highlight groups defined in M.setup() using `vim.api.nvim_set_hl()`
- M.setup() function calls M.update_colors() to select correct palette
- Colors automatically switch when background changes (ColorScheme autocmd)

### Verification
- Highlight groups successfully created: ✓
- Dark mode colors correct (#61afef, #56b6c2, #98c379, #e5c07b, #c678dd, #e06c75) ✓
- Light mode colors correct (#2b6cb0, #2c7a7b, #38a169, #d69e2e, #805ad5, #c53030) ✓
- No LSP diagnostics (errors/warnings) ✓

## [2026-01-27 16:55] Task: Update Neovim Dashboard

### Successful Patterns

**Snacks.nvim Dashboard Configuration**
- Header sections support per-line highlight groups via `text` array with `{text, hl}` tuples
- Git section uses `section = "terminal"` with shell command and `enabled` function guard
- Quick actions use `section = "keys"` with array of `{icon, key, desc, action}` objects
- Fortune/quotes use `section = "text"` with function returning `{{text, hl}}` for dynamic content
- Sections are rendered in array order: header, git, keys, recent_files, session, fortune, startup

**Gradient Highlight Groups**
- Follow existing pattern in highlights.lua: define colors in both dark_palette and light_palette
- Create highlight groups in M.setup() function with `hl(0, "GroupName", { fg = palette.color })`
- Use descriptive color names in palette (e.g., `dashboard_header_1` through `dashboard_header_6`)
- Gradient effect achieved by assigning different highlight groups to each line of ASCII art

**Git Repo Detection**
- Use `vim.fn.isdirectory(".git") == 1` for reliable git repo detection
- Wrap in `enabled = function() return ... end` to conditionally show/hide sections
- Git command: `git branch --show-current 2>/dev/null | awk '{print "  " $0}' || echo ''`
- Gracefully handles non-git directories with fallback to empty string

### Key Technical Decisions

1. **Framework Choice**: snacks.nvim over alpha-nvim
   - Rationale: Maintained by folke, already in config, simpler API
   - Trade-off: Less customization than alpha-nvim, but sufficient for requirements

2. **Telescope Integration**: Used Telescope commands instead of Snacks.picker
   - Rationale: Preserve existing workflow, user familiarity
   - Implementation: `:Telescope find_files`, `:Telescope live_grep` in action strings

3. **Quote Implementation**: Hardcoded array with math.random selection
   - Rationale: No network dependency, instant display, user-controlled content
   - Alternative rejected: External API calls (adds latency, network dependency)

4. **Highlight Strategy**: Theme-adaptive dual palette approach
   - Rationale: Consistency with existing highlights.lua pattern
   - Implementation: Different colors for dark/light mode, same structure

### Gotchas Encountered

**LSP Diagnostics False Positives**
- Lua language server shows "undefined global `vim`" warnings in Neovim config files
- These are expected and safe to ignore - `vim` global is available at runtime
- Actual verification: Load module in headless Neovim and check for real errors

**Dashboard Section Ordering**
- Section order in array determines visual layout
- Must place header first, then git (conditional), then actions/content
- startup section should be last to show timing info at bottom

### File Structure Insights

**Snacks.nvim Config Location**
- Plugin definition: `config/nvim/lua/plugins/snacks.lua`
- Dashboard config: Within `opts.dashboard.sections` array
- Other features preserved: input, picker, terminal, bufdelete, scratch

**Highlights Definition**
- Location: `config/nvim/lua/config/highlights.lua`
- Structure: Palettes defined first, then M.setup() creates highlight groups
- Pattern: Use `hl(0, "Name", { fg = palette.color })` for foreground colors

### Verification Methods

**Static Verification**
- `nvim --headless -c "lua require('module')" -c "q"` - Check module loads
- `:highlight GroupName` - Verify highlight group exists and shows colors
- `lua print(vim.inspect(table))` - Inspect configuration tables

**Dynamic Verification**
- Git detection: Test in git repo vs non-git directory
- Dashboard rendering: Visual inspection on actual startup
- Quick actions: Test keybindings in running Neovim

### Reusable Snippets

**Snacks Dashboard Section Template**
```lua
{
  section = "text",
  text = function()
    -- Dynamic content generation
    return { { "content", hl = "HighlightGroup" } }
  end,
  padding = 1,
}
```

**Conditional Section Template**
```lua
{
  section = "terminal",
  cmd = "command here",
  height = 1,
  enabled = function()
    return condition
  end,
}
```

**Header with Gradient Template**
```lua
{
  section = "header",
  text = {
    { "line1", hl = "Header1" },
    { "line2", hl = "Header2" },
    -- ... cycle through highlight groups
  },
  padding = 1,
}
```

