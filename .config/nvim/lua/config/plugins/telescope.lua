return {
	{
		'nvim-telescope/telescope.nvim',
		branch = 'master',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		opts = function()
			local actions = require('telescope.actions')
			local state = require('telescope.actions.state')

			local new_file = function(prompt_bufnr)
				local entry = state.get_selected_entry() or { value = state.get_current_line() }
				vim.ui.input({ prompt = "please enter file name: ", default = entry.value }, function(input)
					if not (input and input ~= "") then vim.notify("canceled") else
						local prompt = vim.fn.expand('%:p:h') .. '/' .. input
						local success, _ = pcall(function()
							vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
							vim.fn.writefile({}, prompt)
						end)
						if not success then vim.notify("failed to create file") else
							vim.notify("created " .. input)
							vim.cmd("e! " .. prompt)
						end
					end
				end)
			end

			local delete_file = function(prompt_bufnr)
				local picker = state.get_current_picker(prompt_bufnr)
				picker:delete_selection(function(value)
					local file = value[1];
					local ok, _ pcall(function() vim.fs.rm(file) end)
					if ok or ok == nil then vim.notify("removed " .. file) else vim.notify("failed to remove " .. file) end
					return ok
				end)
			end

			local rename_file = function(prompt_bufnr)
				local entry = state.get_selected_entry()
				if not entry then vim.notify("no file selected") else
					vim.ui.input({ prompt = "rename file to: ", default = entry.value }, function(input)
						if not input or input == "" then vim.notify("canceled") else
							local ok, _ = pcall(function() vim.fn.rename(entry.value, input) end)
							if not ok then vim.notify("failed to rename file") else
								local picker = state.get_current_picker(prompt_bufnr)
								for i, v in pairs(picker.finder.results) do if v[1] == entry.value then
										picker.finder.results[i][1] = input
										picker:refresh()
								end end
								vim.notify("renamed file to " .. input)
							end
						end
					end)
				end
			end

			return {
				defaults = {
					preview = {
						filesize_limit = 0.1 -- MB
					},
					initial_mode = "insert",
					winblend = 30,
					file_ignore_patterns = {
						"%.git/.*",
						"^%./lib/.*",
						"^%./bin/.*",
						"%.cache/.*",
						".*%.[od]",
					},
					layout_strategy = 'flex',
					mappings = {
						n = {
							["nf"]	= new_file,
							["df"]	= delete_file,
							["rf"]  = rename_file,
							["q"]		= actions.close,
						}
					}
				},
				pickers = {
					find_files = { follow = true, hidden = true, },
					live_grep = { follow = true, hidden = true, initial_mode = 'insert', },
				}
			}
		end,
		keys = function()
			local builtin = require('telescope.builtin')
			return {
				{ "<leader>fd", desc = "Telescope find files", builtin.find_files, },
				{ "<leader>fs", desc = "Telescope find siblings", function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end, },
				{ "<leader>en", desc = "Telescope edit neovim", function() builtin.find_files({ cwd = vim.fn.stdpath("config"), }) end, },
				{ "<leader>ls", desc = "Telescope show workspace symbols", builtin.lsp_workspace_symbols },
				{ "<leader>bb", desc = "Telescope list builtin pickers", builtin.builtin },
				{ "<leader>ld", desc = "Telescope jump to definition", builtin.lsp_definitions },
				{ "<leader>fg", desc = "Telescope live grep", builtin.live_grep, },
			}
	end,
	}
}
