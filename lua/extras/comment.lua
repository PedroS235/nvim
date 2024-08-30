local M = {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
		},
	},
	lazy = false,
}

function M.config()
	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})

	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	})
end

return M