return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
  },
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- main branch: setup() only takes install_dir; parsers are installed explicitly.
    require("nvim-treesitter").setup({})

    -- install() skips parsers that are already installed.
    require("nvim-treesitter").install({
      "markdown",
      "markdown_inline",
      "bash",
      "c",
      "css",
      "tsx",
      "javascript",
      "typescript",
      "json",
      "vue",
      "regex",
      "lua",
      "rust",
      "vim",
      "vimdoc",
      "python",
      "html",
      "yaml",
      "gotmpl",
      "helm",
    })

    -- jsonc has no parser on main branch; json parser covers it. kulala.nvim manages kulala_http itself.
    vim.treesitter.language.register("json", "jsonc")

    -- main branch no longer auto-attaches parsers/highlighting; start explicitly.
    -- vim.treesitter.start() throws (not just returns false) when no parser
    -- exists for lang, so pcall the whole thing, not just language.add.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or args.match
        local ok = pcall(function()
          vim.treesitter.language.add(lang)
          vim.treesitter.start()
        end)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- main branch textobjects: keymaps are defined by hand.
    local move = require("nvim-treesitter-textobjects.move")
    local function map(lhs, fn, query, desc)
      vim.keymap.set({ "n", "x", "o" }, lhs, function()
        fn(query, "textobjects")
      end, { desc = desc })
    end
    map("]f", move.goto_next_start, "@function.outer", "Next function start")
    map("]]", move.goto_next_start, "@class.outer", "Next class start")
    map("]F", move.goto_next_end, "@function.outer", "Next function end")
    map("][", move.goto_next_end, "@class.outer", "Next class end")
    map("[f", move.goto_previous_start, "@function.outer", "Prev function start")
    map("[[", move.goto_previous_start, "@class.outer", "Prev class start")
    map("[F", move.goto_previous_end, "@function.outer", "Prev function end")
    map("[]", move.goto_previous_end, "@class.outer", "Prev class end")
  end,
}
