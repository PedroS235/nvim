local M = {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local obsidian = require("obsidian")
	local backup_path = "~/Documents/Notes/"

	if not vim.fn.isdirectory(backup_path) then
		vim.fn.mkdir(backup_path, "p")
	end

	local vault_path = os.getenv("SECOND_BRAIN_VAULT") or backup_path

	obsidian.setup({
		ui = { enable = false },
		workspaces = {
			{
				name = "Second Brain",
				path = vault_path,
			},
		},

		notes_subdir = "0_Inbox",

		daily_notes = {
			folder = "4_DailyNotes",
			template = "DailyNoteTemplate.md",
		},

		templates = {
			folder = "99_Templates",
		},

		attachments = {
			img_folder = "98_Assets",
		},

		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},

		---@return table
		note_frontmatter_func = function(note)
			local out = { id = note.id, tags = note.tags }

			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end

			return out
		end,
	})
end

return M
