local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

-- local lspkind = require("lspkind")

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
	return
end

cmp.setup({
	-- Load snippet support
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		-- format = lspkind.cmp_format({
		-- 	mode = "symbol", -- show only symbol annotations
		-- 	maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		-- 	ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		-- 	-- The function below will be called before any actual modifications from lspkind
		-- 	-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		-- }),
	},
	enabled = true,
	debug = false,
	min_length = 2,
	preselect = cmp.PreselectMode.Item,
	source_timeout = 300,
	-- incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	-- Completion settings
	completion = {
		completeopt = "menu,menuone,noselect",
		keyword_length = 2,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	performance = {
		throttle_time = 10,
	},

	-- Key mapping
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping.confirm({
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		--
		--   -- Tab mapping
		--   ['<Tab>'] = function(fallback)
		--     if cmp.visible() then
		--       cmp.select_next_item()
		--     elseif luasnip.expand_or_jumpable() then
		--       luasnip.expand_or_jump()
		--     else
		--       fallback()
		--     end
		--   end,
		--   ['<S-Tab>'] = function(fallback)
		--     if cmp.visible() then
		--       cmp.select_prev_item()
		--     elseif luasnip.jumpable(-1) then
		--       luasnip.jump(-1)
		--     else
		--       fallback()
		--     end
		--   end
	},
	experimental = {
		ghost_text = true,
	},
	-- Load sources, see: https://github.com/topics/nvim-cmp
	sources = {
		-- TODO: currently snippets from lsp end up getting prioritized -- stop that!

		{
			name = "omni",
			priority = 1,
		},
		{ name = "nvim_lsp_signature_help", priority = 2, priority_weight = 100 },
		{ name = "nvim_lsp",                priority = 3 },
		-- { name = "treesitter",              priority = 3 },
		-- { name = "buffer",   priority = 1, false },
		{ name = "path",                    priority = 5 },
		-- { name = "nvim_lua" },
		-- { name = "luasnip" },
		-- sources = {
		-- 	path = true,
		-- 	buffer = false,
		-- 	calc = false,
		-- 	{ name = "nvim_lsp", priority = 4 },
		-- 	nvim_lua = true,
		-- 	vsnip = true,
		-- 	ultisnips = false,
		-- 	luasnip = false,
		-- },
	},
	-- sorting = {
	-- 	priority_weight = 1.0,
	--
	-- 	comparators = {
	-- 		cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
	-- 		cmp.config.compare.locality,
	-- 		cmp.config.compare.offset,
	-- 		cmp.config.compare.order,
	-- 		cmp.config.compare.recently_used,
	-- 	},
	-- },
})
-- Enable completing paths in :
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "cmdline" },
		{ name = "path" },
	}),
})

-- cmp.setup.cmdline({ '/', '?' }, {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		{ name = 'buffer' }
-- 	}
-- })

-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
