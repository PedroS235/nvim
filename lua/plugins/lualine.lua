return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	opts = function(_, opts)
		local ok, noice = pcall(require, "noice")
		local lualine_x = {}

		if ok then
			table.insert(lualine_x, {
				noice.api.statusline.mode.get,
				cond = noice.api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			})
		end

		opts.sections = {
			lualine_x = lualine_x,
		}
	end,
}
