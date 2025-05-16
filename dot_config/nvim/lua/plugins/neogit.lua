local neogit = require('neogit')
local utils = require('utils')

local map = utils.keymap

neogit.setup {}

keymap('n',"<leader>gs", function()
    neogit.open({ })
end);

keymap('n', "<leader>ga", "<cmd>!git fetch --all<CR>");
