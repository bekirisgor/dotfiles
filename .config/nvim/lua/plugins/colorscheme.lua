vim.o.termguicolors = true
local catppuccin = require("catppuccin")

-- vim.api.nvim_command('colorscheme catppuccin')

vim.g.catppuccin_flavour = "mocha"
catppuccin.setup({
	transparent_background = false,
	term_colors = true,
	--[[ dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	}, ]]

	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	integrations = {
		gitsigns = true,
		hop = false,
		cmp = true,
		bufferline = true,
		nvimtree = { enabled = true, show_root = true, transparent_panel = true },
		telescope = true,
		vimwiki = true,
		native_lsp = {
			enabled = true,
		},
	},

	-- highlight_overrides = {
	-- 	all = function(colors)
	-- 		return {CmpBorder = {fg }}
	-- 	end,
	-- },

	custom_highlights = function(colors)
		return {
			DiagnosticVirtualTextError = { bg = "NONE" },
			DiagnosticVirtualTextWarn = { bg = "NONE" },
			DiagnosticVirtualTextInfo = { bg = "NONE" },
			DiagnosticVirtualTextHint = { bg = "NONE" },
			comment = { fg = colors.surface0 },

			-- TSVariable = { fg = "#dcf5e5" },
		}
	end,
	color_overrides = {
		mocha = {
			-- base = "#0d1117",
			-- mantle = "#06080d",
			-- ="#14181D",
			-- yellow = "#F9E2AF",
			-- green = "#A6E3A1",
			-- teal = "#e1eaf5",
			-- sky = "#89DCEB",
			-- sapphire = "#f78f6d",
		},
	},
})

require("rose-pine").setup({
	--- @usage 'main' | 'moon'
	dark_variant = "main",
	bold_vert_split = false,
	dim_nc_background = true,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = "#101017",
		panel = "#101017",
		border = "highlight_med",
		comment = "#333831",
		link = "iris",
		punctuation = "subtle",

		error = "love",
		hint = "highlight_high",
		info = "foam",
		warn = "gold",

		headings = {
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	highlight_groups = {
		ColorColumn = { bg = "rose" },
	},
})

require("kanagawa").setup({
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	variablebuiltinStyle = { italic = true },
	specialReturn = true, -- special highlight for the return keyword
	specialException = true, -- special highlight for exception handling keywords
	transparent = false, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	globalStatus = false, -- adjust window separators highlight for laststatus=3
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- colors = {
	-- 	bg = "#0d1117",
	-- },
	-- overrides = {},
	theme = "default", -- Load "default" theme or the experimental "light" theme
})

require("github-theme").setup({
	-- other config
})

-- vim.cmd ('colorscheme oh-lucy-evening')
vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme catppuccin")
