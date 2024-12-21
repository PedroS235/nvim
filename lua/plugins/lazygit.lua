-- Plugin which makes interaction with lazygit
return {
	"kdheepak/lazygit.nvim",
	enabled = true,
	event = "VeryLazy",
	keys = { { "<leader>lz", "<cmd>lua Snacks.lazygit.open()<CR>", desc = "LazyGit" } },
}
