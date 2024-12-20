-- Plugin which makes interaction with lazygit
return {
	"kdheepak/lazygit.nvim",
	enabled = true,
	event = "VeryLazy",
	keys = { { "<leader>lz", ":LazyGit<CR>", desc = "LazyGit" } },
}
