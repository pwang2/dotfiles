# Decisions - Update Neovim Dashboard

## Architectural Choices

## Trade-offs
## Architectural Decisions - Update Neovim Dashboard

### Decision 1: snacks.nvim vs alpha-nvim
**Date**: 2026-01-27
**Context**: User wanted better startup dashboard, alpha-nvim already disabled in config
**Decision**: Use snacks.nvim as dashboard framework
**Rationale**:
- Already installed and configured in dotfiles
- Actively maintained by folke (trusted Neovim plugin author)
- Simpler API than alpha-nvim for configuration
- Integrates well with other snacks features (input, picker, terminal)
**Consequences**:
- Less customization flexibility than alpha-nvim
- Limited to snacks' section types and layout system
- But: Sufficient for all requirements (header, git, keys, quotes, files, session)

### Decision 2: Telescope vs Snacks.picker
**Date**: 2026-01-27
**Context**: Quick actions needed file/grep pickers
**Decision**: Use Telescope commands instead of Snacks.picker
**Rationale**:
- User already familiar with Telescope workflow
- Preserves muscle memory and keybindings
- Telescope more feature-rich for file finding
- Consistency with rest of Neovim config
**Consequences**:
- Mixed picker usage (Telescope + Snacks available)
- Dashboard actions use `:Telescope find_files` / `:Telescope live_grep`
- vim.ui.select still uses Snacks.picker (preserved from original config)

### Decision 3: Hardcoded Quotes vs External API
**Date**: 2026-01-27
**Context**: Fortune/quote section needs content source
**Decision**: Use hardcoded array of 7 programming quotes with math.random
**Rationale**:
- No network dependency (instant startup, works offline)
- User controls content (no inappropriate/random quotes)
- Simple implementation (no API keys, rate limits, error handling)
- Sufficient variety for daily use
**Consequences**:
- Quotes don't change unless config updated
- Limited to hardcoded set (vs infinite external quotes)
- But: Meets requirement for "rotating quotes" via randomization

### Decision 4: Theme-Adaptive Gradient Colors
**Date**: 2026-01-27
**Context**: Gradient header needs to work in dark and light mode
**Decision**: Define separate color palettes for dark/light modes
**Rationale**:
- Consistency with existing highlights.lua pattern
- Dark mode needs bright colors (#61afef blues/cyans)
- Light mode needs deep colors (#2b6cb0 darker variants)
- Auto-switches via ColorScheme autocmd
**Consequences**:
- Doubled color definitions (6 colors × 2 palettes = 12 definitions)
- But: Ensures readability in both themes
- Follows established project pattern

### Decision 5: Git Section with Enabled Guard
**Date**: 2026-01-27
**Context**: Git status should show only in git repos
**Decision**: Use `enabled = function() return vim.fn.isdirectory(".git") == 1 end`
**Rationale**:
- Graceful degradation (hidden when not in git repo)
- No error messages in non-git directories
- Simple, reliable detection method
- Section dynamically shows/hides on dashboard refresh
**Consequences**:
- Detects only git repos with .git directory (not bare repos)
- But: Covers 99% of use cases for user's workflow

### Decision 6: Quick Action Keybindings
**Date**: 2026-01-27
**Context**: User had muscle memory from alpha-nvim dashboard
**Decision**: Preserve exact keybindings from disabled alpha-nvim config
**Keys**: f (find), g (grep), n (new), c (config), m (mason), p (mcphub), u (update), h (health), q (quit)
**Rationale**:
- Minimize cognitive load during transition
- User already trained on these keys
- Dashboard-local bindings don't conflict with global maps
**Consequences**:
- Smooth migration from alpha-nvim to snacks
- No retraining needed

### Decision 7: Section Ordering
**Date**: 2026-01-27
**Context**: Dashboard sections determine visual layout
**Decision**: Order: header, git, keys, recent_files, session, fortune, startup
**Rationale**:
- Header first (branding, visual anchor)
- Git next (contextual info about current location)
- Keys central (primary actions, easy to reach)
- Files/sessions below (secondary content)
- Fortune near bottom (break/inspiration)
- Startup last (meta-info about Neovim itself)
**Consequences**:
- Logical flow from identity → context → actions → content → meta
- User sees most important info (header, git, actions) without scrolling
