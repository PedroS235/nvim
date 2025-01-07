-- Plugin which gives auto-completion capabilities. Another plugin is nvim-cmp
return {
	{
		"saghen/blink.cmp",
		version = "*",
		enabled = true,
		dependencies = "rafamadriz/friendly-snippets",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				cmdline = {},
			},

			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
