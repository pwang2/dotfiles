return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,

    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
      },
      icon = {
        folder_empty_open = "",
        use_filtered_colors = true,
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "*",
      },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "✖",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },

    window = {
      position = "left",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        -- nvim-tree compatible mappings
        -- expand_nested_files: first press expands nesting, second press opens the file
        ["<CR>"] = { "open", config = { expand_nested_files = true } },
        ["o"] = { "open", config = { expand_nested_files = true } },
        ["<2-LeftMouse>"] = { "open", config = { expand_nested_files = true } },
        ["<2-RightMouse>"] = "set_root",
        ["<Tab>"] = "open_preview",

        -- Splits (nvim-tree defaults + custom overrides)
        ["<C-v>"] = "open_vsplit",
        ["<C-x>"] = "open_split",
        ["<C-t>"] = "open_tabnew",
        ["s"] = "open_vsplit", -- custom override from tree.lua
        ["i"] = "open_split", -- custom override from tree.lua

        -- Navigation
        ["<C-]>"] = "set_root",
        ["<BS>"] = "close_node",
        ["-"] = "navigate_up",
        ["u"] = "navigate_up", -- custom override from tree.lua
        ["P"] = "navigate_up", -- parent (nvim-tree uses P for parent)

        -- File operations
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["d"] = "delete",
        ["r"] = "rename",
        ["R"] = "refresh",

        -- Copy/paste (nvim-tree compatible)
        ["c"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["y"] = "copy_to_clipboard",

        -- Expand/Collapse
        ["W"] = "close_all_nodes",
        ["E"] = "expand_all_nodes",

        -- Filters
        ["H"] = "toggle_hidden",
        ["I"] = "toggle_hidden", -- nvim-tree uses I for toggle git ignored
        ["f"] = "filter_on_submit",
        ["F"] = "clear_filter",

        -- Help & info
        ["g?"] = "show_help",
        ["?"] = "show_help",
        ["<C-k>"] = "show_file_details",

        -- Close
        ["q"] = "close_window",
        ["<esc>"] = "cancel",

        -- Git navigation
        ["[c"] = "prev_git_modified",
        ["]c"] = "next_git_modified",

        -- Source navigation (neo-tree specific)
        ["<"] = "prev_source",
        [">"] = "next_source",
      },
    },

    nesting_rules = {
      -- Extension-based rules: key = item.exts (everything after the first dot).
      -- Value entries are the child file's exts; neo-tree looks for
      -- a sibling named  <parent-base>.<child-ext>.

      -- JavaScript / TypeScript
      ["js"] = { "js.map", "test.js", "spec.js" },
      ["jsx"] = { "test.jsx", "spec.jsx" },
      ["ts"] = { "ts.map", "test.ts", "spec.ts", "d.ts" },
      ["tsx"] = { "test.tsx", "spec.tsx", "stories.tsx" },

      -- React components (e.g. Button.component.tsx)
      ["component.tsx"] = {
        "component.test.tsx",
        "component.spec.tsx",
        "component.stories.tsx",
        "component.module.css",
        "component.module.scss",
        "component.styles.ts",
      },
      ["component.jsx"] = {
        "component.test.jsx",
        "component.spec.jsx",
        "component.stories.jsx",
        "component.module.css",
        "component.module.scss",
      },

      -- Stylesheets
      ["css"] = { "css.map" },
      ["scss"] = { "scss.map", "css", "css.map" },
      ["sass"] = { "sass.map", "css", "css.map" },
      ["less"] = { "less.map", "css", "css.map" },

      -- Vue / Svelte (test/spec/stories files only; "vue.ts" removed — unusual naming)
      ["vue"] = { "test.ts", "test.js", "spec.ts", "spec.js", "stories.ts", "stories.js" },
      ["svelte"] = { "test.ts", "test.js", "spec.ts", "spec.js" },

      -- Pattern-based rules: use { pattern = "...", files = {...} } for specific
      -- filenames (multi-dot names or dotfiles) because item.exts only captures
      -- everything after the FIRST dot, so "vite.config.ts" → exts = "config.ts".

      -- Package manager
      ["package.json"] = {
        pattern = "^package%.json$",
        files = {
          "package-lock.json",
          "yarn.lock",
          "pnpm-lock.yaml",
          "bun.lockb",
          ".npmrc",
          ".yarnrc",
          ".yarnrc.yml",
        },
      },

      -- TypeScript
      ["tsconfig.json"] = {
        pattern = "^tsconfig%.json$",
        files = { "tsconfig.base.json", "tsconfig.node.json", "tsconfig.app.json", "tsconfig.test.json" },
      },

      -- Vite
      ["vite.config.ts"] = {
        pattern = "^vite%.config%.ts$",
        files = {
          "vite.config.js",
          "vite.config.mjs",
          "vite.alias.ts",
          "vite.alias.js",
          "vite.proxy.ts",
          "vite.proxy.js",
        },
      },
      ["vite.config.js"] = {
        pattern = "^vite%.config%.js$",
        files = { "vite.config.mjs", "vite.alias.js", "vite.alias.ts", "vite.proxy.js", "vite.proxy.ts" },
      },

      -- Webpack
      ["webpack.config.js"] = {
        pattern = "^webpack%.config%.js$",
        files = { "webpack.config.ts", "webpack.dev.js", "webpack.prod.js" },
      },

      -- Environment variables
      [".env"] = {
        pattern = "^%.env$",
        files = { ".env.local", ".env.development", ".env.production", ".env.test", ".env.example" },
      },

      -- Tailwind
      ["tailwind.config.js"] = {
        pattern = "^tailwind%.config%.js$",
        files = { "tailwind.config.ts", "postcss.config.js", "postcss.config.ts" },
      },

      -- ESLint
      [".eslintrc.js"] = {
        pattern = "^%.eslintrc%.js$",
        files = { ".eslintrc.json", ".eslintrc.yml", ".eslintignore" },
      },
      ["eslint.config.js"] = {
        pattern = "^eslint%.config%.js$",
        files = { "eslint.config.mjs", "eslint.config.ts" },
      },

      -- Prettier
      [".prettierrc"] = {
        pattern = "^%.prettierrc$",
        files = { ".prettierrc.js", ".prettierrc.json", ".prettierrc.yml", ".prettierignore" },
      },

      -- Next.js
      ["next.config.js"] = {
        pattern = "^next%.config%.js$",
        files = { "next.config.mjs", "next.config.ts", "next-env.d.ts" },
      },

      -- Vitest / Jest
      ["vitest.config.ts"] = {
        pattern = "^vitest%.config%.ts$",
        files = { "vitest.config.js", "vitest.config.mjs" },
      },
      ["jest.config.js"] = {
        pattern = "^jest%.config%.js$",
        files = { "jest.config.ts", "jest.setup.js", "jest.setup.ts" },
      },
    },

    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["og"] = { "order_by_git_status", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
        fuzzy_finder_mappings = {
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },
    },

    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
    },

    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
  },
}
