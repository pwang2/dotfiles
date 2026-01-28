# Update Neovim Dashboard

## TL;DR

> **Quick Summary**: Enhance the snacks.nvim dashboard with a colorful Neovim ASCII logo header, git status info, quick actions, and rotating programming quotes.
> 
> **Deliverables**:
> - OpenSpec change files in `openspec/changes/update-neovim-dashboard/`
> - Enhanced `config/nvim/lua/plugins/snacks.lua` with full dashboard configuration
> - Updated `config/nvim/lua/config/highlights.lua` with gradient highlight groups
> - Optional cleanup of disabled `config/nvim/lua/plugins/startup.lua`
> 
> **Estimated Effort**: Short (1-2 hours)
> **Parallel Execution**: NO - sequential (highlights must exist before snacks uses them)
> **Critical Path**: Task 1 (highlights) -> Task 2 (snacks dashboard) -> Task 3 (cleanup)

---

## Context

### Original Request
User wants to build a better startup dashboard for Neovim.

### Interview Summary
**Key Discussions**:
- **Framework**: snacks.nvim (already in config, recommended by folke)
- **Header**: Neovim logo ASCII art with colorful gradients
- **Sections**: Recent files (cwd), Quick actions, Git status, System info, Fortune/Quote
- **Quick actions**: Find file, Live grep, New file, Config, Mason, MCPHub, Update plugins, Health check, Quit
- **Visual style**: Colorful with gradients (theme-adaptive for light/dark)

**Research Findings**:
- snacks.nvim dashboard supports custom sections via `section` and `text` types
- Can use inline functions for dynamic content (git status, fortune)
- Built-in highlight groups: `SnacksDashboardIcon`, `SnacksDashboardDesc`, `SnacksDashboardKey`
- Need custom highlight groups for gradient header effect

### Metis Review
**Identified Gaps** (addressed):
- **StartLogo highlights missing**: Will add to highlights.lua with dark/light variants
- **Light/dark mode**: Will use theme-adaptive colors following existing pattern
- **Picker choice**: Will use Telescope (preserve existing workflow)
- **Fortune source**: User chose hardcoded rotating quotes
- **Git repo guard**: Will use `enabled` function to check for git directory
- **Quick action keys**: Will preserve alpha-nvim keys (f, n, c, m, p, u, h, q)

---

## Work Objectives

### Core Objective
Transform the basic snacks.nvim dashboard into a feature-rich, visually appealing startup screen with Neovim branding, quick actions, git info, and motivational quotes.

### Concrete Deliverables
1. `openspec/changes/update-neovim-dashboard/proposal.md` - Change proposal
2. `openspec/changes/update-neovim-dashboard/tasks.md` - Implementation checklist
3. `openspec/changes/update-neovim-dashboard/specs/nvim-dashboard/spec.md` - Requirements spec
4. `config/nvim/lua/config/highlights.lua` - Add `SnacksDashboardHeader1-6` gradient highlights
5. `config/nvim/lua/plugins/snacks.lua` - Enhanced dashboard configuration
6. `config/nvim/lua/plugins/startup.lua` - Removed (optional cleanup)

### Definition of Done
- [x] Dashboard displays on Neovim startup with ASCII header
- [x] Header shows gradient colors (verifiable via `:highlight SnacksDashboardHeader1`)
- [x] Git branch/status displays when in git directory
- [x] Git section hidden when not in git directory
- [x] All 9 quick actions work with correct keybindings
- [x] Fortune quote displays and changes on reload
- [x] Dashboard works in both dark and light mode

### Must Have
- Neovim ASCII logo header with gradient effect
- Recent files from current working directory
- 9 quick action buttons with keyboard shortcuts
- Git branch display (when in git repo)
- System info (startup time)
- Rotating programming quotes

### Must NOT Have (Guardrails)
- DO NOT add new plugin dependencies
- DO NOT change keybindings outside dashboard context
- DO NOT add project section (not requested)
- DO NOT use Snacks.picker (keep Telescope for consistency)
- DO NOT modify other snacks.nvim features (input, picker, terminal, bufdelete, scratch)
- DO NOT add external API calls for quotes (no network dependency)

---

## Verification Strategy (MANDATORY)

### Test Decision
- **Infrastructure exists**: NO (config files, manual testing per project.md)
- **User wants tests**: Manual-only
- **Framework**: None - Visual verification

### Manual QA Procedures

**Dashboard renders on startup:**
```bash
nvim
# Expected: Dashboard appears with ASCII header, sections visible
```

**Verify highlight groups exist:**
```vim
:highlight SnacksDashboardHeader1
# Expected: Shows color definition, not "E411: highlight group not found"
```

**Verify git status in git repo:**
```bash
cd ~/dotfiles && nvim
# Expected: Git section shows branch name (e.g., "main")
```

**Verify git status hidden outside git:**
```bash
cd /tmp && nvim
# Expected: No git section visible, no errors
```

**Verify dark/light mode:**
```vim
:set background=light
:lua Snacks.dashboard()
# Expected: Colors adapt, still readable
```

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 0 (Start Immediately):
└── Task 0: Create OpenSpec change proposal files

Wave 1 (After Wave 0):
└── Task 1: Add gradient highlights to highlights.lua

Wave 2 (After Wave 1):
└── Task 2: Update snacks.lua dashboard config

Wave 3 (After Wave 2):
└── Task 3: Remove startup.lua (optional cleanup)

Critical Path: Task 0 → Task 1 → Task 2 → Task 3
Parallel Speedup: N/A (sequential dependencies)
```

### Dependency Matrix

| Task | Depends On | Blocks | Can Parallelize With |
|------|------------|--------|---------------------|
| 0 | None | 1 | None |
| 1 | 0 | 2 | None |
| 2 | 1 | 3 | None |
| 3 | 2 | None | None |

### Agent Dispatch Summary

| Wave | Tasks | Recommended Dispatch |
|------|-------|---------------------|
| 0 | 0 | `delegate_task(category="quick", load_skills=[])` |
| 1 | 1 | `delegate_task(category="quick", load_skills=[])` |
| 2 | 2 | `delegate_task(category="quick", load_skills=[])` |
| 3 | 3 | `delegate_task(category="quick", load_skills=["git-master"])` |

---

## TODOs

- [x] 0. Create OpenSpec change proposal files

  **What to do**:
  - Create directory `openspec/changes/update-neovim-dashboard/specs/nvim-dashboard/`
  - Create `openspec/changes/update-neovim-dashboard/proposal.md` with:
    - Why: Current dashboard is basic, needs Neovim branding and productivity features
    - What Changes: Add highlights, enhance dashboard config, remove alpha-nvim
    - Impact: Affects highlights.lua, snacks.lua, startup.lua
  - Create `openspec/changes/update-neovim-dashboard/tasks.md` with implementation checklist
  - Create `openspec/changes/update-neovim-dashboard/specs/nvim-dashboard/spec.md` with requirements:
    - Neovim Dashboard Header (gradient colors, theme adaptation)
    - Git Status Display (contextual, hidden outside git)
    - Quick Actions (9 buttons with keybindings)
    - Programming Quotes (rotating display)

  **Must NOT do**:
  - Do not create specs in the wrong location
  - Do not skip scenario definitions

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Creating structured markdown files following OpenSpec format
  - **Skills**: `[]`
    - No special skills needed

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 0 (first)
  - **Blocks**: Task 1
  - **Blocked By**: None (can start immediately)

  **References**:

  **Pattern References** (existing code to follow):
  - `openspec/AGENTS.md:157-205` - Proposal structure and spec delta format
  - `openspec/AGENTS.md:237-255` - Scenario formatting rules (use `####` headers)

  **Acceptance Criteria**:

  **Manual Execution Verification:**
  - [ ] Run: `openspec validate update-neovim-dashboard --strict`
  - [ ] Expected: Validation passes with no errors
  - [ ] Run: `openspec show update-neovim-dashboard`
  - [ ] Expected: Shows proposal content

  **Commit**: YES
  - Message: `docs(openspec): add change proposal for neovim dashboard`
  - Files: `openspec/changes/update-neovim-dashboard/*`
  - Pre-commit: `openspec validate update-neovim-dashboard --strict`

---

- [x] 1. Add gradient highlight groups for dashboard header

  **What to do**:
  - Open `config/nvim/lua/config/highlights.lua`
  - Add `SnacksDashboardHeader1` through `SnacksDashboardHeader6` to both `dark_palette` and `light_palette`
  - Add highlight definitions in the `M.setup()` function
  - Use colors that create a gradient effect (blues/greens/cyans for dark, deeper variants for light)

  **Must NOT do**:
  - Do not remove existing highlight definitions
  - Do not change the pattern of how colors are defined

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Single file modification, straightforward addition following existing pattern
  - **Skills**: `[]`
    - No special skills needed for Lua config editing

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 1 (sequential)
  - **Blocks**: Task 2
  - **Blocked By**: None (can start immediately)

  **References**:

  **Pattern References** (existing code to follow):
  - `config/nvim/lua/config/highlights.lua:14-83` - Dark palette color definitions (follow this structure)
  - `config/nvim/lua/config/highlights.lua:86-155` - Light palette color definitions (follow this structure)
  - `config/nvim/lua/config/highlights.lua:163-183` - Highlight group definitions (follow this pattern)

  **Suggested Colors** (dark palette gradient - blues to cyans):
  ```lua
  -- Dashboard header gradient
  dashboard_header_1 = "#61afef",  -- Bright blue
  dashboard_header_2 = "#56b6c2",  -- Cyan-blue
  dashboard_header_3 = "#98c379",  -- Green
  dashboard_header_4 = "#e5c07b",  -- Yellow
  dashboard_header_5 = "#c678dd",  -- Purple
  dashboard_header_6 = "#e06c75",  -- Red-pink
  ```

  **Acceptance Criteria**:

  **Manual Execution Verification:**
  - [ ] Open Neovim: `nvim`
  - [ ] Run: `:highlight SnacksDashboardHeader1`
  - [ ] Expected: Shows `SnacksDashboardHeader1 xxx guifg=#61afef` (or similar)
  - [ ] Run: `:set background=light`
  - [ ] Run: `:highlight SnacksDashboardHeader1`
  - [ ] Expected: Shows different color value for light mode

  **Commit**: YES
  - Message: `feat(nvim): add gradient highlights for dashboard header`
  - Files: `config/nvim/lua/config/highlights.lua`
  - Pre-commit: `nvim --headless -c "lua require('config.highlights').setup()" -c "q"` (no errors)

---

- [x] 2. Update snacks.nvim dashboard configuration

  **What to do**:
  - Open `config/nvim/lua/plugins/snacks.lua`
  - Replace the basic `dashboard` config (lines 28-38) with enhanced configuration
  - Add ASCII Neovim logo header with line-by-line highlight assignments
  - Add git status section with `enabled` guard for git directories
  - Add quick actions section with all 9 buttons
  - Add fortune/quotes section with rotating hardcoded quotes
  - Preserve recent_files, session, and startup sections
  - Keep all other snacks features unchanged (input, picker, terminal, bufdelete, scratch)

  **Must NOT do**:
  - Do not modify lines 1-27 or 39-82 (other snacks features)
  - Do not use Snacks.picker (use Telescope commands)
  - Do not add external dependencies

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Single file modification, config enhancement
  - **Skills**: `[]`
    - No special skills needed

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 2 (after Task 1)
  - **Blocks**: Task 3
  - **Blocked By**: Task 1

  **References**:

  **Pattern References** (existing code to follow):
  - `config/nvim/lua/plugins/snacks.lua:28-38` - Current dashboard config (replace this section)
  - `config/nvim/lua/plugins/startup.lua:119-128` - ASCII art header pattern
  - `config/nvim/lua/plugins/startup.lua:172-200` - Quick action buttons (use same keys/icons)

  **API References** (snacks.nvim dashboard):
  - Section types: `header`, `keys`, `recent_files`, `session`, `startup`, `terminal`, `text`
  - Custom section: `{ section = "terminal", cmd = "...", height = N, enabled = function() end }`
  - Keys format: `{ icon = "...", key = "f", desc = "Find File", action = ":Telescope find_files" }`

  **ASCII Logo** (Neovim standard):
  ```
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  ```

  **Quick Actions** (preserve alpha-nvim keys):
  | Key | Icon | Description | Action |
  |-----|------|-------------|--------|
  | f | 󰀶 | Find file | `:Telescope find_files` |
  | g | 󰊄 | Live grep | `:Telescope live_grep` |
  | n |  | New file | `:ene \| startinsert` |
  | c |  | Config | `:e $MYVIMRC \| cd %:h` |
  | m |  | Mason | `:Mason` |
  | p |  | MCPHub | `:MCPHub` |
  | u |  | Update | `:Lazy update` |
  | h |  | Health | `:checkhealth` |
  | q | 💨 | Quit | `:qa` |

  **Programming Quotes** (example set):
  ```lua
  local quotes = {
    "The best code is no code at all.",
    "First, solve the problem. Then, write the code.",
    "Code is like humor. When you have to explain it, it's bad.",
    "Simplicity is the soul of efficiency.",
    "Make it work, make it right, make it fast.",
  }
  ```

  **Acceptance Criteria**:

  **Manual Execution Verification:**
  - [ ] Open Neovim: `nvim`
  - [ ] Expected: Dashboard appears with Neovim ASCII logo in colors
  - [ ] Press `f`: Opens Telescope file finder
  - [ ] Press `g`: Opens Telescope live grep
  - [ ] Press `q`: Quits Neovim
  - [ ] Run in git repo: `cd ~/dotfiles && nvim`
  - [ ] Expected: Git section shows branch name
  - [ ] Run outside git: `cd /tmp && nvim`
  - [ ] Expected: No git section, no errors
  - [ ] Reload dashboard: `:lua Snacks.dashboard()`
  - [ ] Expected: Quote may change (random selection)

  **Commit**: YES
  - Message: `feat(nvim): enhance snacks dashboard with header, git, actions, quotes`
  - Files: `config/nvim/lua/plugins/snacks.lua`
  - Pre-commit: `nvim --headless -c "lua require('plugins.snacks')" -c "q"` (no errors)

---

- [x] 3. Remove disabled alpha-nvim config (optional cleanup)

  **What to do**:
  - Delete `config/nvim/lua/plugins/startup.lua`
  - This file contains disabled alpha-nvim config that's no longer needed

  **Must NOT do**:
  - Do not delete until Task 2 is verified working
  - Do not remove any other files

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Single file deletion
  - **Skills**: `["git-master"]`
    - For clean commit

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 3 (final)
  - **Blocks**: None
  - **Blocked By**: Task 2

  **References**:
  - `config/nvim/lua/plugins/startup.lua` - File to delete (currently 220 lines, `enabled = false`)

  **Acceptance Criteria**:

  **Manual Execution Verification:**
  - [ ] Verify file removed: `ls config/nvim/lua/plugins/startup.lua` returns "No such file"
  - [ ] Open Neovim: `nvim`
  - [ ] Expected: Dashboard still works, no errors about missing startup.lua
  - [ ] Run: `:Lazy`
  - [ ] Expected: alpha-nvim not listed as a plugin

  **Commit**: YES
  - Message: `chore(nvim): remove disabled alpha-nvim config`
  - Files: `config/nvim/lua/plugins/startup.lua` (deleted)
  - Pre-commit: None needed

---

## Commit Strategy

| After Task | Message | Files | Verification |
|------------|---------|-------|--------------|
| 1 | `feat(nvim): add gradient highlights for dashboard header` | highlights.lua | `:highlight SnacksDashboardHeader1` shows color |
| 2 | `feat(nvim): enhance snacks dashboard with header, git, actions, quotes` | snacks.lua | Dashboard renders on startup |
| 3 | `chore(nvim): remove disabled alpha-nvim config` | startup.lua (deleted) | Neovim starts without errors |

---

## Success Criteria

### Verification Commands
```vim
" In Neovim:
:highlight SnacksDashboardHeader1    " Shows color definition
:lua Snacks.dashboard()              " Dashboard renders without errors
:checkhealth snacks                  " No errors for snacks.nvim
```

```bash
# In terminal:
nvim --headless -c "lua print(vim.inspect(require('snacks').config.dashboard))" -c "q"
# Expected: Prints dashboard config table
```

### Final Checklist
- [x] Neovim ASCII logo displays with gradient colors
- [x] All 9 quick actions work (f, g, n, c, m, p, u, h, q)
- [x] Git status shows in git repos, hidden elsewhere
- [x] Fortune quote displays and varies
- [x] Recent files section works
- [x] Session section works
- [x] Startup time displays
- [x] Works in dark mode
- [x] Works in light mode
- [x] No errors on startup
- [x] alpha-nvim config removed (startup.lua deleted)
