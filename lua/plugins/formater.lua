-- Plugin to use code formatters
return {
	"stevearc/conform.nvim",
	enabled = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 500 })
			end,
			mode = "",
			desc = "[C]ode [F]ormat",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				async = false,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			bash = { "beautysh" },
			sh = { "beautysh" },
			zsh = { "beautysh" },
			cpp = { "clang-format" },
			c = { "clang-format" },
			markdown = { "prettier" },
			yaml = { "prettier" },
			html = { "prettier" },
			typescript = { "prettier" },
			javascript = { "prettier" },
			typescriptreact = { "prettier" },
			javascriptreact = { "prettier" },
		},
	},
}
