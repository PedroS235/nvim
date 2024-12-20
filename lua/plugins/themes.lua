-- Colorschemes
return {
	{
		"folke/tokyonight.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,

		opts = {
			style = "moon", -- `storm|moon|night|day`
			transparent = false,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
			},
		},
	},

	{
		"navarasu/onedark.nvim",
		enabled = true,
		priority = 1000,
		lazy = false,
		opts = {
			style = "darker", -- 'dark|darker|cool|deep|warm|warmer|light'
			transparent = false,

			code_style = {
				comments = "italic",
				functions = "bold",
			},
		},
	},

	{
		"catppuccin/nvim",
		priority = 1000,
		lazy = false,
		enabled = true,
		name = "catppuccin",
		opts = {
			flavour = "mocha",
			transparent_background = false,
			term_colors = false,
			styles = {
				comments = { "italic" },
				functions = { "bold" },
			},
		},
	},
}
