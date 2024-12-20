return {
	{
		"saghen/blink.cmp",
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

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
