local null_ls = require("null-ls")
--[[ local function select_null_ls_client()
	local clients = vim.tbl_values(vim.lsp.buf_get_clients())
	for _, client in ipairs(clients) do
		if client.name == "null-ls" then
			return client
		end
	end
	return nil
end

-- ref: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/buf.lua#L177
_G.formatting = function(bufnr, options, timeout_ms)
	local client = select_null_ls_client()
	if client == nil then
		vim.notify("failed selecting null-ls client", vim.log.levels.WARN)
		return
	end

	bufnr = tonumber(bufnr) or vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_formatting_params(options)
	local result, err = client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
	if result and result.result then
		vim.lsp.util.apply_text_edits(result.result, bufnr, client.offset_encoding)
	elseif err then
		vim.notify("vim.lsp.buf.format(): " .. err, vim.log.levels.WARN)
	end
end ]]

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	debug = false,
	sources = {
		-- require("typescript.extensions.null-ls.code-actions"),
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.autopep8.with({
		-- 	filetypes = { "python" },
		-- 	extra_args = { "--indent-size=2" },
		-- }),
		null_ls.builtins.formatting.black,
		-- null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.formatting.isort,
		-- null_ls.builtins.formatting.prettier_d_slim,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.diagnostics.yamllint,
		-- null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.hadolint,
		-- on_attach = on_attach,
	},
	-- on_attach = function(client)
	-- 	if client.server_capabilities.document_formatting then
	-- 		vim.cmd([[
	--      augroup LspFormatting
	--        autocmd! * <buffer>
	--        autocmd BufWritePre <buffer> luanull_ls.builtins.format()
	--      augroup END
	--      ]])
	-- 	end
	-- end,
})
