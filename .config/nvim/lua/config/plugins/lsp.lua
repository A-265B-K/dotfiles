return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			{
				"neovim/nvim-lspconfig",
				dependencies = {
					{
						"folke/lazydev.nvim",
						ft = "lua",
						opts = {
							library = {
								{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
							},
						},
					},
					{ "saghen/blink.cmp" },
				},
				opts = {
					servers = {
						lua_ls = {}, -- lua
						clangd = {}, -- c/cpp
						nil_ls = {}, -- nix
						bashls = {}, -- sh/bash
						norm_ls = {}, -- 42 norminette
						hls = {}, -- haskell
						asm_lsp = {}, -- asm
						rust_analyzer = {}, -- rust
						ruff = {}, -- python
						ty = {}, -- python
						eslint = {}, -- js/ts
						tinymist = {}, -- typst
					},
				},
				config = function(_, opts)
					for server, config in pairs(opts.servers) do
						config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
						vim.lsp.enable(server)
					end
					vim.lsp.config("rust_analyzer", {
						settings = {
							["rust-analyzer"] = {
								check = { command = "clippy" },
							},
						},
					})
				end,
			},
		},
		opts = {
			ensure_installed = {},
		},
	},
}
