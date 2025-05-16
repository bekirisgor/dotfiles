local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	indent = {
		enable = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = "<CR>",
			-- scope_incremental = "<CR>",
			-- node_incremental = "<TAB>",
			-- node_decremental = "<S-TAB>",
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		additional_vim_regex_highlighting = true,
		use_languagetree = true,
		disable = function(lang, buf)
			local max_filesize = 50 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
})
