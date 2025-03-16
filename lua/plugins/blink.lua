-- Plugin which gives auto-completion capabilities. Another plugin is nvim-cmp
return {
	{
		"saghen/blink.cmp",
		version = "0.13.0",
		enabled = true,
		dependencies = "rafamadriz/friendly-snippets",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },

			appearance = {
				nerd_font_variant = "mono",
			},

			cmdline = {
				enabled = false,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
