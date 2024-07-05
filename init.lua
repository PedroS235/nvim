require("core.options")
require("core.keymaps")
require("core.launch")
require("core.autocmds")

spec("core.mason")
spec("core.telescope")
spec("core.treesitter")

spec("lsp.lsp")
spec("lsp.cmp")
spec("lsp.conform")
spec("lsp.schema-store")
-- spec("lsp.null-ls")

-- Extras
spec("extras.nvim-tree")
spec("extras.comment")
spec("extras.lualine")
spec("extras.gitsigns")
spec("extras.bufferline")
spec("extras.surround")
spec("extras.lazygit")
spec("extras.markdown-preview")
spec("extras.illuminate")
spec("extras.which-key")
spec("extras.dropbar")
spec("extras.indentline")
spec("extras.diffview")
spec("extras.harpoon")
spec("extras.bqf")
spec("extras.obsidian")
spec("extras.todo-comments")
spec("extras.tmux-navigator")
spec("extras.vim-sleuth")
spec("extras.project")
spec("extras.mini")
spec("extras.noice")
-- spec("extras.oil")

-- spec("extras.copilot")

-- spec("themes.tokyonight")
-- spec("themes.onedark")
spec("themes.catppuccin")

require("core.lazy")
