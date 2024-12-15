return {
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local opts = { noremap = true, silent = true }
			local keymap = vim.keymap.set

			keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

			require("nvim-tree").setup({
				actions = {
					open_file = {
						quit_on_open = true,
						window_picker = {
							enable = false,
						},
					},
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = true,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",

		keys = {
			{ "<leader>e", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},

		opts = {
			commands = {
				-- If item is a file close neotree after opening it.
				open_and_close_neotree = function(state)
					require("neo-tree.sources.filesystem.commands").open(state)

					local tree = state.tree
					local success, node = pcall(tree.get_node, tree)

					if not success then
						return
					end

					if node.type == "file" then
						require("neo-tree.command").execute({ action = "close" })
					end
				end,
			},
			filesystem = {
				window = {
					mappings = {
						["<leader>e"] = "close_window",
						["<CR>"] = "open_and_close_neotree",
						["<S-CR>"] = "open",
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},
		},
	},
}
