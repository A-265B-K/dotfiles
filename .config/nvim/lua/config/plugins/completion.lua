return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{
				"L3MON4D3/luasnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				build = "make install_jsregexp",
				version = "v2.*",
				config = function()
					require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/snippets" } })
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		version = "1.*",
		opts = {
			snippets = { preset = "luasnip" },
			keymap = {
				preset = "default",
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				documentation = {
					auto_show = false,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
