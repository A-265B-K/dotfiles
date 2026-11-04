-- lua/config/plugins/mini.lua
return {
	{
		'echasnovski/mini.nvim',
		config = function()
			local clue = require 'mini.clue'
			local icons = require 'mini.icons'
			local git = require 'mini.git'
			local diff = require 'mini.diff'
			local statusline = require 'mini.statusline'
			local hipatterns = require 'mini.hipatterns'
			local ai = require 'mini.ai'
			local notify = require 'mini.notify'
			local surround = require 'mini.surround'

			clue.setup({
				triggers = {
					{ mode = 'n', keys = "<leader>" },
					{ mode = 'n', keys = "g" },
					{ mode = 'n', keys = "z" },
					{ mode = 'i', keys = "<C-x>" },
				},
				clues = {
					clue.gen_clues.builtin_completion(),
					clue.gen_clues.g(),
					clue.gen_clues.marks(),
					clue.gen_clues.registers(),
					clue.gen_clues.windows(),
					clue.gen_clues.z(),
				},
				window = {
					delay = 500,
				},
			})
			icons.setup {}
			git.setup {}
			diff.setup {}
			statusline.setup { use_icons = true }
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					hack	= { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
					todo	= { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
					note	= { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
					file	= { pattern = '%f[%w]()FILE()%f[%W]',  group = 'MiniHipatternsNote'  },
					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
			ai.setup {}
			notify.setup {}
			vim.notify = notify.make_notify()
			surround.setup {}
		end
	}
}
