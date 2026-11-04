--- @param mode string|string[]
--- @param lhs string|string[]
--- @param rhs string|function
--- @param opts? vim.keymap.set.Opts
local map = function(mode, lhs, rhs, opts)
	if type(lhs) == "table" then
		for _, cmd in ipairs(lhs) do
			vim.keymap.set(mode, cmd, rhs, opts)
		end
	else
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

map("n", "<leader><leader>x", ":source %<CR>", { desc = "source current file" })
map("n", "<leader><leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "reload init.lua" })
map("n", "<leader>x", ":.lua<CR>", { desc = "interpret and run current line as lua" })
map("v", "<leader>x", ":lua<CR>", { desc = "interpret and run current selection as lua" })
map("n", "<leader>l", ":noh<CR>", { desc = "clear search highlight"})
-- hjkl supremacy
map({"n", "v", "i"}, {"<left>", "<right>", "<up>", "<down>"}, function()
	vim.notify('hjkl supremacy', vim.log.levels.ERROR)
end, { desc = "hjkl supremacy" })
-- lsp
map("n", "gre", vim.diagnostic.setloclist, { desc = "display error information"})
map("n", "gse", function()
	vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "toggle inline errors" })
map("n", "gle", function()
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = "toggle virtual line errors" })
