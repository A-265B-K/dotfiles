local uc = vim.api.nvim_create_user_command
local ac = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

-- User commands
uc("W", "w|e", { desc = "write file then refresh buffer" })

-- Auto commands
ac("TextYankPost", {
	desc = "Highlight when yanking text",
	group = aug("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.hl_op()
	end,
})
ac("LspAttach", {
	desc = "Notify user about attached LSP clients",
	group = aug("LSPOnAttach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client then
			vim.notify(client.name .. " attached", vim.log.levels.INFO, {})
		end
	end,
})
-- ac("LspAttach", {
-- 	group = aug("lsp_attach_disable_ruff_hover", { clear = true }),
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client == nil then
-- 			return
-- 		end
-- 		if client.name == "ruff" then
-- 			client.server_capabilities.hoverProvider = false
-- 		end
-- 	end,
-- 	desc = "LSP: Disable hover capabilties for ruff",
-- })
