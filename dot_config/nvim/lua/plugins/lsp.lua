local lsp_status_ok, lspconfig = pcall(require, "lspconfig")

if not lsp_status_ok then
	return
end

-- local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not cmp_status_ok then
-- 	return
-- end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "jsonls", "ts_ls" },
})

-- Show line diagnostics automatically in hover window
-- vim.cmd([[
--   autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
-- ]])

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
-- 	if err ~= nil or result == nil then
-- 		return
-- 	end
--
-- 	if not vim.api.nvim_buf_get_option(bufnr, "modified") then
-- 		local view = vim.fn.winsaveview()
-- 		vim.lsp.util.apply_text_edits(result, bufnr)
-- 		vim.fn.winrestview(view)
-- 		if bufnr == vim.api.nvim_get_current_buf() then
-- 			vim.api.nvim_command("noautocmd :update")
-- 		end
-- 	end
-- end

-- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- local win = require("lspconfig.ui.windows")
-- local _default_opts = win.default_opts
--
-- win.default_opts = function(options)
-- 	local opts = _default_opts(options)
-- 	options.border = 'single'
-- 	return opts
-- end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- -- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- -- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = {
-- 		"documentation",
-- 		"detail",
-- 	},
-- }

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
	require("ts-error-translator").translate_diagnostics(err, result, ctx)
	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end

local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- Completion configuration
-- vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	if client.name == "ts_ls" then
		client.server_capabilities.semanticTokens = false
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end

	-- Highlighting references
	-- if client.server_capabilities.document_highlight then
	-- 	vim.api.nvim_exec(
	-- 		[[
	--       augroup lsp_document_highlight
	--         autocmd! * <buffer>
	--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	--       augroup END
	--     ]],
	-- 		false
	-- 	)
	-- end

	-- Enable completion triggered by <c-x><c-o>
	-- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wg", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>ql", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({async = false})<CR>", opts)

	-- require("lsp_signature").on_attach({
	-- 	doc_lines = 10,
	-- 	max_height = 20,
	-- 	floating_window = false,
	-- 	padding = "  ",
	-- 	handler_opts = {
	-- 		border = "single",
	-- 	},
	-- })
end

--[[
Language servers setup:
For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
Language server installed:
Bash          -> bashls
Python        -> pyright
C-C++         -> clangd
HTML/CSS/JSON -> vscode-html-languageserver
JavaScript/TypeScript -> tsserver
--]]

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
--
local root_dir = function()
	return vim.fn.getcwd()
end

lspconfig.pyright.setup({
	on_attach = on_attach,
	settings = {
		pyright = { autoImportCompletion = true },
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			},
		},
	},
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:

-- require("typescript").setup({
-- 	disable_commands = false, -- prevent the plugin from creating Vim commands
-- 	debug = false,         -- enable debug logging for commands
-- 	go_to_source_definition = {
-- 		fallback = true,   -- fall back to standard LSP definition on failure
-- 	},
-- 	server = {             -- pass options to lspconfig's setup method
-- 		on_attach = function(client, bufnr)
-- 			on_attach(client, bufnr)
--
-- 			local function buf_set_keymap(...)
-- 				vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 			end
--
-- 			local opts = { noremap = true, silent = true }
-- 			buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
-- 			client.server_capabilities.document_formatting = false
-- 		end,
-- 	},
-- 	-- function(client, bufnr)
-- 	-- 			-- on_attach(client, bufnr)
-- 	-- 			local function buf_set_keymap(...)
-- 	-- 				vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 	-- 			end
-- 	--
-- 	-- 			local opts = { noremap = true, silent = true }
-- 	--
-- 	-- 			buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
-- 	-- 			client.server_capabilities.document_formatting = false
-- 	-- 		end,
--
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- })

local servers = {
	"bashls",
	"clangd",
	"html",
	"cssls",
	"cssmodules_ls",
	"yamlls",
	"jsonls",
	"dockerls",
	"astro",
	"rust_analyzer",
	"lua_ls",
	"tailwindcss",
	"csharp_ls",
	"vscode-eslint-language-server",
	"ts_ls",
}
-- Call setup
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		-- root_dir = root_dir,
		capabilities = capabilities,
		flags = {
			-- default in neovim 0.7+
			debounce_text_changes = 300,
		},
		root_dir = root_dir,
	})
end

local opts = {
	tools = { -- rust-tools options

		-- how to execute terminal commands
		-- options right now: termopen / quickfix
		executor = require("rust-tools.executors").termopen,

		-- callback to execute once rust-analyzer is done initializing the workspace
		-- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
		on_initialized = nil,

		-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
		reload_workspace_from_cargo_toml = true,

		-- These apply to the default RustSetInlayHints command
		inlay_hints = {
			-- automatically set inlay hints (type hints)
			-- default: true
			auto = true,

			-- Only show inlay hints for the current line
			only_current_line = false,

			-- whether to show parameter hints with the inlay hints or not
			-- default: true
			show_parameter_hints = false,

			-- prefix for parameter hints
			-- default: "<-"
			parameter_hints_prefix = "<- ",

			-- prefix for all the other hints (type, chaining)
			-- default: "=>"
			other_hints_prefix = "=> ",

			-- whether to align to the length of the longest line in the file
			max_len_align = false,

			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,

			-- whether to align to the extreme right or not
			right_align = false,

			-- padding from the right if right_align is true
			right_align_padding = 7,

			-- The color of the hints
			highlight = "Comment",
		},

		-- options same as lsp hover / vim.lsp.util.open_floating_preview()
		hover_actions = {

			-- the border that is used for the hover window
			-- see vim.api.nvim_open_win()
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},

			-- Maximal width of the hover window. Nil means no max.
			max_width = nil,

			-- Maximal height of the hover window. Nil means no max.
			max_height = nil,

			-- whether the hover action window gets automatically focused
			-- default: false
			auto_focus = false,
		},

		-- settings for showing the crate graph based on graphviz and the dot
		-- command
		crate_graph = {
			-- Backend used for displaying the graph
			-- see: https://graphviz.org/docs/outputs/
			-- default: x11
			backend = "x11",
			-- where to store the output, nil for no output stored (relative
			-- path from pwd)
			-- default: nil
			output = nil,
			-- true for all crates.io and external crates, false only the local
			-- crates
			-- default: true
			full = true,

			-- List of backends found on: https://graphviz.org/docs/outputs/
			-- Is used for input validation and autocompletion
			-- Last updated: 2021-08-26
			enabled_graphviz_backends = {
				"bmp",
				"cgimage",
				"canon",
				"dot",
				"gv",
				"xdot",
				"xdot1.2",
				"xdot1.4",
				"eps",
				"exr",
				"fig",
				"gd",
				"gd2",
				"gif",
				"gtk",
				"ico",
				"cmap",
				"ismap",
				"imap",
				"cmapx",
				"imap_np",
				"cmapx_np",
				"jpg",
				"jpeg",
				"jpe",
				"jp2",
				"json",
				"json0",
				"dot_json",
				"xdot_json",
				"pdf",
				"pic",
				"pct",
				"pict",
				"plain",
				"plain-ext",
				"png",
				"pov",
				"ps",
				"ps2",
				"psd",
				"sgi",
				"svg",
				"svgz",
				"tga",
				"tiff",
				"tif",
				"tk",
				"vml",
				"vmlz",
				"wbmp",
				"webp",
				"xlib",
				"x11",
			},
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	server = {
		-- standalone file support
		-- setting it to false may improve startup time
		on_attach = on_attach,
		standalone = true,
	}, -- rust-analyzer options

	-- debugging stuff
}

require("rust-tools").setup(opts)
-- require("lspconfig.ui.windows").default_options.border = "single"
