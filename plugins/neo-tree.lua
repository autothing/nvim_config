local get_icon = require("astronvim.utils").get_icon

local function on_file_remove(args)
end

local function on_file_rename(args)
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "miversen33/netman.nvim" },
  opts = function(_, opts)
    local events = require "neo-tree.events"
    local lsp_type = require("user.config.lsp_type").lsp_type
    local event_handlers = {}
    if lsp_type == "coc" then
      event_handlers = {
        {
          event = events.FILE_MOVED,
          handler = on_file_remove,
        },
        {
          event = events.FILE_RENAMED,
          handler = on_file_remove,
        },
      }
    end
    return require("astronvim.utils").extend_tbl(opts, {
      event_handlers = event_handlers,
      close_if_last_window = true,
      sources = {
        "filesystem",
        "netman.ui.neo-tree",
        "git_status",
      },
      source_selector = {
        sources = {
          { source = "filesystem", display_name = get_icon "FolderClosed" .. " File" },
          -- { source = "remote", display_name = "󰒍 Remote" },
          -- { source = "git_status", display_name = get_icon "Git" .. " Git" },
        },
      },
      filesystem = {
        filtered_items = {
          always_show = { ".github", ".gitignore" },
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            "noder_modules",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },

    })
  end,
}
