-- vim.o.clipboard = 'unnamedplus'
--
--
vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

vim.o.shell = "/bin/bash"
vim.o.termguicolors = true
vim.cmd("syntax enable")
vim.o.visualbell = true
vim.o.errorbells = false
vim.o.showcmd = true
vim.o.mouse = "a"
vim.o.foldenable = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.lazyredraw = true
vim.o.synmaxcol = 500
vim.o.laststatus = 10
vim.o.linebreak = true
vim.o.timeoutlen = 800

vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.autoindent = true
vim.o.preserveindent = true
vim.o.scrolloff = 2

vim.o.ruler = false
vim.o.showmode = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.ttyfast = true
vim.o.autowrite = true
vim.o.autoread = true
vim.o.updatetime = 300
vim.o.cmdheight = 1
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.history = 100

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.backspace = "indent,eol,start"
vim.wo.wrap = false
vim.wo.cursorline = false
vim.wo.signcolumn = "yes"
vim.o.hidden = true

vim.o.fileencodings = "utf-8"

vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smartindent = false
vim.o.smarttab = true

vim.o.formatoptions = vim.o.formatoptions .. "tcrqbn"
vim.o.wildmenu = true
vim.o.wildmode = "list:longest"

vim.o.wildignore =
	".hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor"

vim.o.listchars = "nbsp:¬,extends:»,precedes:«,trail:•"

vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

vim.opt.diffopt:append("context:3")
vim.opt.diffopt:append("horizontal")
vim.opt.diffopt:append("internal")
vim.opt.diffopt:append("foldcolumn:0")
vim.opt.diffopt:append("hiddenoff")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:append("algorithm:patience")

-- vim.opt.shortmess:append "sI"

-- -- Disable builtin plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	-- "netrw",
	-- "netrwPlugin",
	-- "netrwSettings",
	-- "netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
