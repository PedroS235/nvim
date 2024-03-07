-- Slightly modified from:
-- https://github.com/LunarVim/Launch.nvim/blob/master/lua/user/lspconfig.lua
local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	virtual_text = false,
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(
		bufnr,
		"n",
		"<leader>ih",
		"<cmd>lua require('pedros.lsp').toggle_inlay_hints()<cr>",
		{ desc = "Toggle Inlay Hints" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>vt",
		"<cmd>lua require('pedros.lsp').toggle_virtual_text()<cr>",
		{ desc = "Toggle Inlay Hints" }
	)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(bufnr, false)
	end
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local state = vim.lsp.inlay_hint.is_enabled(bufnr)
	vim.lsp.inlay_hint.enable(bufnr, not state)
end

M.toggle_virtual_text = function()
	M.virtual_text = not M.virtual_text
	vim.diagnostic.config({ virtual_text = M.virtual_text })
end

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.offsetEncoding = { "utf-16" }
		return capabilities
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	return capabilities
end

function M.config()
	local lspconfig = require("lspconfig")
	local icons = require("pedros.icons")
	local servers = require("mason-lspconfig").get_installed_servers()

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = M.virtual_text,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		local require_ok, settings = pcall(require, "pedros.lsp_settings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		lspconfig[server].setup(opts)
	end
end

return M
