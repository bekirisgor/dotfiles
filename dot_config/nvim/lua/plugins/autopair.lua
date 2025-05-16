local autopair = require("nvim-autopairs")
autopair.setup({
	check_ts = true,
	enable_check_bracket_line = true,
})
autopair.add_rules(require("nvim-autopairs.rules.endwise-lua"))
