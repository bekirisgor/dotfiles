local status_blink, blink = pcall(require, "blink.cmp")
if not status_blink then
	return
end

local trigger_text = ";"
blink.setup({
	require("blink.cmp").setup({
		-- Sources configuration
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					min_keyword_length = 0,
					score_offset = 90,
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
					fallbacks = { "snippets", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 4,
					score_offset = 15,
				},
				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 15,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 85,
					should_show_items = function()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						return before_cursor:match(trigger_text .. "%w*$") ~= nil
					end,
					transform_items = function(_, items)
						local line = vim.api.nvim_get_current_line()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = line:sub(1, col)
						local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
						if start_pos then
							for _, item in ipairs(items) do
								if not item.trigger_text_modified then
									item.trigger_text_modified = true
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
										},
									}
								end
							end
						end
						return items
					end,
				},
				-- emoji = {
				--   module = 'blink-emoji',
				--   name = 'Emoji',
				--   score_offset = 93,
				--   min_keyword_length = 2,
				--   opts = { insert = true },
				-- },
				-- dictionary = {
				--   module = 'blink-cmp-dictionary',
				--   name = 'Dict',
				--   score_offset = 20,
				--   enabled = true,
				--   max_items = 8,
				--   min_keyword_length = 3,
				--   opts = {
				--     dictionary_directories = { vim.fn.expand('~/github/dotfiles-latest/dictionaries') },
				--     dictionary_files = {
				--       vim.fn.expand('~/github/dotfiles-latest/neovim/neobean/spell/en.utf-8.add'),
				--       vim.fn.expand('~/github/dotfiles-latest/neovim/neobean/spell/es.utf-8.add'),
				--     },
				--   },
				-- },
			},
		},

		-- Command-line completion
		cmdline = {
			enabled = true,
		},

		-- Completion settings
		completion = {
			menu = {
				border = "single",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},

		-- Snippets
		snippets = {
			preset = "luasnip",
		},

		-- Keymappings
		keymap = {
			preset = "default",
			["<C-space>"] = { "show" },
			["<Tab>"] = { "select_and_accept", "fallback" },
		},
	}),

	fuzzy = {
		-- Controls which implementation to use for the fuzzy matcher.
		--
		-- 'prefer_rust_with_warning' (Recommended) If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
		-- 'prefer_rust' If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
		-- 'rust' Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
		-- 'lua' Always use the Lua implementation, doesn't download any prebuilt binaries
		--
		-- See the prebuilt_binaries section for controlling the download behavior
		implementation = "prefer_rust_with_warning",

		-- Allows for a number of typos relative to the length of the query
		-- Set this to 0 to match the behavior of fzf
		-- Note, this does not apply when using the Lua implementation.
		max_typos = function(keyword)
			return math.floor(#keyword / 4)
		end,

		-- Frecency tracks the most recently/frequently used items and boosts the score of the item
		-- Note, this does not apply when using the Lua implementation.
		use_frecency = true,

		-- Proximity bonus boosts the score of items matching nearby words
		-- Note, this does not apply when using the Lua implementation.
		use_proximity = true,

		-- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database. This should only be used on unsupported platforms (i.e. alpine termux)
		-- Note, this does not apply when using the Lua implementation.
		use_unsafe_no_lock = false,

		-- Controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
		-- You may pass a function instead of a string to customize the sorting
		sorts = {
			-- (optionally) always prioritize exact matches
			-- 'exact',

			-- pass a function for custom behavior
			-- function(item_a, item_b)
			--   return item_a.score > item_b.score
			-- end,

			"score",
			"sort_text",
		},

		prebuilt_binaries = {
			-- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
			-- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
			-- Disabled by default when `fuzzy.implementation = 'lua'`
			download = true,

			-- Ignores mismatched version between the built binary and the current git sha, when building locally
			ignore_version_mismatch = false,

			-- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
			-- then the downloader will attempt to infer the version from the checked out git tag (if any).
			--
			-- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
			force_version = nil,

			-- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
			-- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
			-- Check the latest release for all available system triples
			--
			-- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
			force_system_triple = nil,

			-- Extra arguments that will be passed to curl like { 'curl', ..extra_curl_args, ..built_in_args }
			extra_curl_args = {},
		},
	},

	-- -- Disable blink.cmp for specific filetypes (approximation of Lazy's dynamic enabling)
	-- vim.api.nvim_create_autocmd('FileType', {
	--   pattern = { 'TelescopePrompt', 'minifiles', 'snacks_picker_input' },
	--   callback = function()
	--     require('blink.cmp').disable()
	--   end,
	-- })
})
