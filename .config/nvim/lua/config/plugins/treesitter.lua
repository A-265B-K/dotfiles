return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function(opts)
			local ts = require("nvim-treesitter")
			local ensure_installed = { "c", "cpp", "lua", "markdown", "markdown_inline", "nix", "haskell" }
			ts.setup(opts)

			-- for _,ft in ipairs(ensure_installed) do
			-- 	vim.api.nvim_create_autocmd('FileType', {
			-- 		pattern = { ft },
			-- 		callback = function()
			-- 			vim.treesitter.start()
			-- 		end,
			-- 	})
			-- end
		end,
		opts = {},
	},
}
