return {
  "nvim-tree/nvim-tree.lua",
  -- enabled = false,
  version = "*",
  cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFile" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>t", "<cmd>:NvimTreeToggle<cr>", desc = "toggle nvim-tree" },
  },
  config = function()
    local opts = {
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = "name",
      },
      view = {
        width = {
          max = 36,
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          window_picker = {
            enable = false, --disable du to conflict with
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      live_filter = {
        prefix = " : ",
        always_show_folders = true, -- Turn into false from true by default
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function optsFn(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end
        api.map.on_attach.default(bufnr)

        vim.keymap.del("n", "<C-e>", { buffer = bufnr })
        vim.keymap.set("n", "s", api.node.open.vertical, optsFn("Open: V Split"))
        vim.keymap.set("n", "i", api.node.open.horizontal, optsFn("Open: H Split"))
        vim.keymap.set("n", "u", api.tree.change_root_to_parent, optsFn("Up"))
      end,
    }
    require("nvim-tree").setup(opts)

    --  Add the Snacks integration
    local events = require("nvim-tree.api").events
    local prev = { new_name = "", old_name = "" }

    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
        prev = { new_name = data.new_name, old_name = data.old_name }
      end
    end)
  end,
}
