-- A fuzzy finder plugin
return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		enabled = true,
		config = function()
			local actions = require("telescope.actions")
			local icons = require("config.icons")

			require("telescope").setup({
				defaults = {
					prompt_prefix = icons.ui.Telescope .. " ",
					selection_caret = icons.ui.Forward .. " ",
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				pickers = {
					find_files = { previewer = true },
					live_grep = { theme = "dropdown", previewer = true },
					grep_string = { theme = "dropdown", previewer = true },
					buffers = {
						theme = "dropdown",
						previewer = false,
						initial_mode = "normal",
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
							n = {
								["dd"] = actions.delete_buffer,
							},
						},
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find Git Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
			vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find String" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
			vim.keymap.set("n", "<leader>fh", builtin.command_history, { desc = "Find command History" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = 'Find Recent Files ("." for repeat)' })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",

		build = "make",

		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- Useful for getting pretty icons, but requires a Nerd Font.
	{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
}
