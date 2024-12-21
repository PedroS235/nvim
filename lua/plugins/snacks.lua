-- A set of useful plugins by folke
return {
	"folke/snacks.nvim",
	enabled = true,
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		lazygit = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
	},
}
