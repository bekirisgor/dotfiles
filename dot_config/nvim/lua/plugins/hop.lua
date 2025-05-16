local u = require("utils")

require("hop").setup {keys = "asdfjklqweruiopzxcvnm"}

u.keymap("n", "<C-l>", "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true, silent = true})
