local execute = vim.api.nvim_commandsetup
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- things
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	---GUI
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" })
	-- use("~/Desktop/DEV/testproject/bufferline.nvim")
	use("mhinz/vim-startify")
	use("xiyaowong/nvim-transparent")
	-- Default config
	-- use({
	-- 	"Faywyn/llama-copilot.nvim",
	-- 	requires = "nvim-lua/plenary.nvim",
	-- 	-- config = function()
	-- 	-- 	require("llama-copilot").setup({
	-- 	-- 		host = "localhost",
	-- 	-- 		port = "11434",
	-- 	-- 		model = "codellama:7b-code",
	-- 	-- 		max_completion_size = 100, -- use -1 for limitless
	-- 	-- 		debug = false,
	-- 	-- 	})
	-- 	-- end,
	-- })

	-- ColorSchemes
	use("savq/melange")
	use("navarasu/onedark.nvim")
	use("rebelot/kanagawa.nvim")
	use({ "projekt0n/github-nvim-theme" })
	use({ "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" })
	use({ "rose-pine/neovim", as = "rose-pine" })
	-- Typing features
	--[[ use({
					"kylechui/nvim-surround",
					tag = "*", -- Use for stability; omit to use `main` branch for the latest features
					config = function()
						require("nvim-surround").setup({
							-- Configuration here, or leave empty to use defaults
						})
					end,
				}) ]]
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-rhubarb")
	-- use("windwp/nvim-autopairs")

	--Git
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("tpope/vim-fugitive")

	-- IDE Enhancement
	use("nvim-tree/nvim-web-devicons")
	use({ "nvim-tree/nvim-tree.lua" })
	-- use({ "stevearc/oil.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-raw.nvim" },
		},
	})
	use("nvim-telescope/telescope-fzy-native.nvim")
	-- use("ThePrimeagen/git-worktree.nvim")
	-- use({
	-- 	"notjedi/nvim-rooter.lua",
	-- 	config = function()
	-- 		require("nvim-rooter").setup()
	-- 	end,
	-- })
	-- use("ThePrimeagen/harpoon")
	use({ "phaazon/hop.nvim", as = "hop" })
	use("lewis6991/impatient.nvim")
	-- use({ "vimwiki/vimwiki" })
	-- use("lukas-reineke/indent-blankline.nvim")

	use({
		"Kicamon/wiki.nvim",
		config = function()
			require("wiki").setup({
				path = "~/wiki/", -- wiki dire
				wiki_open = "<leader>ww", -- open wiki index
				wiki_file = "<cr>", -- create or open a file
			})
		end,
	})

	-- Languages
	-- use("leafgarland/typescript-vim")
	use("jose-elias-alvarez/typescript.nvim")
	use("MaxMEllon/vim-jsx-pretty")
	use("jparise/vim-graphql")
	use("fatih/vim-go")
	use("simrat39/rust-tools.nvim")

	use({
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		requires = { "echasnovski/mini.nvim", opt = true }, -- if you use the mini.nvim suite
		-- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
		-- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "vimwiki", "Avante" },
				vim.treesitter.language.register("markdown", "vimwiki"),
			})
		end,
	})
	use("norcalli/nvim-colorizer.lua")

	-- Languages enhancemenet
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")
	use("nvimtools/none-ls.nvim")

	-- AI tools
	-- use("zbirenbaum/copilot.lua")
	-- use("HakonHarnes/img-clip.nvim")
	use({
		"greggh/claude-code.nvim",
		requires = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		config = function()
			require("claude-code").setup({
				-- Terminal window settings
				window = {
					split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
					position = "botright", -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
					enter_insert = true, -- Whether to enter insert mode when opening Claude Code
					hide_numbers = true, -- Hide line numbers in the terminal window
					hide_signcolumn = true, -- Hide the sign column in the terminal window
				},
				-- File refresh settings
				refresh = {
					enable = true, -- Enable file change detection
					updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
					timer_interval = 1000, -- How often to check for file changes (milliseconds)
					show_notifications = true, -- Show notification when files are reloaded
				},
				-- Git project settings
				git = {
					use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
				},
				-- Command settings
				command = "claude", -- Command used to launch Claude Code
				-- Command variants
				command_variants = {
					-- Conversation management
					continue = "--continue", -- Resume the most recent conversation
					resume = "--resume", -- Display an interactive conversation picker

					-- Output options
					verbose = "--verbose", -- Enable verbose logging with full turn-by-turn output
				},
				-- Keymaps
				keymaps = {
					toggle = {
						normal = "<C-h>", -- Normal mode keymap for toggling Claude Code, false to disable
						terminal = "<C-h>", -- Terminal mode keymap for toggling Claude Code, false to disable
						variants = {
							continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
							verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
						},
					},
					window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
					scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
				},
			})
		end,
	})
	-- use({
	-- 	"yetone/avante.nvim", -- Specifies the plugin repository.
	-- 	build = "make", -- Runs the "make" command after cloning the plugin.
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons", -- Adds file icons for Neovim.
	-- 		"stevearc/dressing.nvim", -- Provides improved UI components for Neovim.
	-- 		"nvim-lua/plenary.nvim", -- A dependency that provides useful Lua functions.
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	--
	-- 		"HakonHarnes/img-clip.nvim",
	--
	-- 		{
	-- 			"grapp-dev/nui-components.nvim", -- A plugin for additional UI components.
	-- 			dependencies = {
	-- 				"MunifTanjim/nui.nvim", -- A required dependency for "nui-components.nvim".
	-- 			},
	-- 		},
	-- 		{
	-- 			"MeanderingProgrammer/render-markdown.nvim", -- Adds markdown rendering support.
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" }, -- Specifies the file types that this plugin will handle.
	-- 			},
	-- 			ft = { "markdown", "Avante" },   -- Specifies that the plugin should only load for these file types.
	-- 		},
	-- 	},
	-- })
	--
	use("ibhagwan/fzf-lua")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("grapp-dev/nui-components.nvim")
	use("MunifTanjim/nui.nvim")

	-- use({
	-- 	"Exafunction/codeium.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- })
	-- use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	use("supermaven-inc/supermaven-nvim")

	-- LSP Things
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use({
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				auto_update = true,
				debounce_hours = 24,
				ensure_installed = {
					"black",
					"isort",
				},
			})
		end,
	})

	use("onsails/lspkind-nvim")
	-- use("glepnir/lspsaga.nvim")
	--use({ "simrat39/symbols-outline.nvim" }, require("symbols-outline").setup())
	use("nvim-lua/lsp-status.nvim")
	use("ray-x/lsp_signature.nvim")
	use("pantharshit00/vim-prisma")
	use({
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup({
				auto_cmd = true, -- Enable inline diagnostics
			})
		end,
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	use("L3MON4D3/LuaSnip")

	-- Completion (replacing nvim-cmp with blink.cmp)
	use({
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets", -- For snippet support
			"L3MON4D3/LuaSnip", -- Retain LuaSnip for snippet preset
		},
		-- Use a release tag for pre-built binaries
		version = "v1.*",
		-- Optional: Build from source if you have nightly Rust
		build = "cargo build --release",
	})
	use("sindrets/diffview.nvim")

	-- use("lukas-reineke/cmp-under-comparator")
	-- use("saadparwaiz1/cmp_luasnip")
	--
	--
	-- Custom
	use("~/Development/dependency-tree.nvim")
	use({
		"~/Development/code-explorer.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("code-explorer").setup({
				-- Maximum recursion depth for exploration
				max_depth = 2,

				-- Patterns to exclude from exploration
				exclude_patterns = {},

				-- Include references to the selected item
				include_references = true,

				-- Include implementations of the selected item
				include_implementations = true,

				-- Include definitions of the selected item
				include_definitions = true,

				-- Include type definitions
				include_type_definitions = true,

				-- Include document symbols
				include_document_symbols = true,

				-- Include folder structure in output
				include_folder_structure = true,

				-- Keymap to trigger the explorer
				keymap = "<leader>ce",

				-- Copy results to clipboard
				copy_to_clipboard = true,

				-- Options for the floating window
				float_opts = {
					relative = "cursor",
					width = 80,
					height = 40,
					border = "rounded",
					style = "minimal",
				},
			})
		end,
	})
	-- 	use({
	-- 		"~/Development/deep_tree.nvim",
	-- 		config = function()
	-- 			require("deep_tree").setup({
	-- 				include = {
	-- 					references = true,
	-- 					definitions = true,
	-- 					implementations = true,
	-- 					type_definitions = true,
	-- 					document_symbols = true,
	-- 					outgoing_calls = true,
	-- 					incoming_calls = true,
	-- 					comments = true,
	-- 					types = true,
	-- 					interfaces = true,
	-- 				},
	-- 				debug = true, -- For testing
	-- 			})
	-- 		end,
	-- 	})
end)
