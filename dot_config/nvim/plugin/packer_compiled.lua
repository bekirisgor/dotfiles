-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/bekirisgor/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?.lua;/Users/bekirisgor/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?/init.lua;/Users/bekirisgor/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?.lua;/Users/bekirisgor/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/bekirisgor/.cache/nvim/packer_hererocks/2.1.1741730670/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["blink.cmp"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/blink.cmp",
    url = "https://github.com/saghen/blink.cmp"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["claude-code.nvim"] = {
    config = { "\27LJ\2\nÑ\4\0\0\6\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\15\0005\4\f\0005\5\r\0=\5\14\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\fkeymaps\vtoggle\1\0\3\14scrolling\2\vtoggle\0\22window_navigation\2\rvariants\1\0\2\fverbose\15<leader>cV\rcontinue\15<leader>cC\1\0\3\vnormal\n<C-h>\rvariants\0\rterminal\n<C-h>\21command_variants\1\0\3\fverbose\14--verbose\vresume\r--resume\rcontinue\15--continue\bgit\1\0\1\17use_git_root\2\frefresh\1\0\4\23show_notifications\2\19timer_interval\3è\a\15updatetime\3d\venable\2\vwindow\1\0\6\fcommand\vclaude\21command_variants\0\fkeymaps\0\vwindow\0\frefresh\0\bgit\0\1\0\5\rposition\rbotright\16split_ratio\4³æÌ™\3³æÌþ\3\20hide_signcolumn\2\17hide_numbers\2\17enter_insert\2\nsetup\16claude-code\frequire\0" },
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/claude-code.nvim",
    url = "https://github.com/greggh/claude-code.nvim"
  },
  ["code-explorer.nvim"] = {
    config = { "\27LJ\2\nŽ\3\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\2B\0\2\1K\0\1\0\15float_opts\1\0\5\vborder\frounded\nwidth\3P\rrelative\vcursor\nstyle\fminimal\vheight\3(\21exclude_patterns\1\0\v\29include_type_definitions\2\24include_definitions\2\28include_implementations\2\23include_references\2\21exclude_patterns\0\14max_depth\3\2\vkeymap\15<leader>ce\15float_opts\0\22copy_to_clipboard\2\29include_folder_structure\2\29include_document_symbols\2\nsetup\18code-explorer\frequire\0" },
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/code-explorer.nvim",
    url = "/Users/bekirisgor/Development/code-explorer.nvim"
  },
  ["dependency-tree.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/dependency-tree.nvim",
    url = "/Users/bekirisgor/Development/dependency-tree.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["fzf-lua"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  hop = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/hop",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    config = { "\27LJ\2\n¢\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\3\0\0\nblack\nisort\1\0\3\21ensure_installed\0\19debounce_hours\3\24\16auto_update\2\nsetup\25mason-tool-installer\frequire\0" },
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  melange = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/melange",
    url = "https://github.com/savq/melange"
  },
  ["mini.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/opt/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  ["none-ls.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/none-ls.nvim",
    url = "https://github.com/nvimtools/none-ls.nvim"
  },
  ["nui-components.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nui-components.nvim",
    url = "https://github.com/grapp-dev/nui-components.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-transparent"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["render-markdown.nvim"] = {
    config = { "\27LJ\2\n×\1\0\0\a\0\f\1\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\0039\3\t\3'\5\n\0'\6\v\0B\3\3\0?\3\0\0B\0\2\1K\0\1\0\fvimwiki\rmarkdown\rregister\rlanguage\15treesitter\bvim\15file_types\1\0\1\15file_types\0\1\4\0\0\rmarkdown\fvimwiki\vAvante\nsetup\20render-markdown\frequire\3€€À™\4\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/opt/render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"
  },
  ["rose-pine"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["supermaven-nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/supermaven-nvim",
    url = "https://github.com/supermaven-inc/supermaven-nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-live-grep-raw.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/telescope-live-grep-raw.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-raw.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["ts-error-translator.nvim"] = {
    config = { "\27LJ\2\nR\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rauto_cmd\2\nsetup\24ts-error-translator\frequire\0" },
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/ts-error-translator.nvim",
    url = "https://github.com/dmmulroy/ts-error-translator.nvim"
  },
  ["typescript.nvim"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-go",
    url = "https://github.com/fatih/vim-go"
  },
  ["vim-graphql"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-graphql",
    url = "https://github.com/jparise/vim-graphql"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty",
    url = "https://github.com/MaxMEllon/vim-jsx-pretty"
  },
  ["vim-prisma"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-prisma",
    url = "https://github.com/pantharshit00/vim-prisma"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-startify",
    url = "https://github.com/mhinz/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["wiki.nvim"] = {
    config = { "\27LJ\2\nj\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\14wiki_file\t<cr>\tpath\f~/wiki/\14wiki_open\15<leader>ww\nsetup\twiki\frequire\0" },
    loaded = true,
    path = "/Users/bekirisgor/.local/share/nvim/site/pack/packer/start/wiki.nvim",
    url = "https://github.com/Kicamon/wiki.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: code-explorer.nvim
time([[Config for code-explorer.nvim]], true)
try_loadstring("\27LJ\2\nŽ\3\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\2B\0\2\1K\0\1\0\15float_opts\1\0\5\vborder\frounded\nwidth\3P\rrelative\vcursor\nstyle\fminimal\vheight\3(\21exclude_patterns\1\0\v\29include_type_definitions\2\24include_definitions\2\28include_implementations\2\23include_references\2\21exclude_patterns\0\14max_depth\3\2\vkeymap\15<leader>ce\15float_opts\0\22copy_to_clipboard\2\29include_folder_structure\2\29include_document_symbols\2\nsetup\18code-explorer\frequire\0", "config", "code-explorer.nvim")
time([[Config for code-explorer.nvim]], false)
-- Config for: mason-tool-installer.nvim
time([[Config for mason-tool-installer.nvim]], true)
try_loadstring("\27LJ\2\n¢\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\3\0\0\nblack\nisort\1\0\3\21ensure_installed\0\19debounce_hours\3\24\16auto_update\2\nsetup\25mason-tool-installer\frequire\0", "config", "mason-tool-installer.nvim")
time([[Config for mason-tool-installer.nvim]], false)
-- Config for: claude-code.nvim
time([[Config for claude-code.nvim]], true)
try_loadstring("\27LJ\2\nÑ\4\0\0\6\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\15\0005\4\f\0005\5\r\0=\5\14\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\fkeymaps\vtoggle\1\0\3\14scrolling\2\vtoggle\0\22window_navigation\2\rvariants\1\0\2\fverbose\15<leader>cV\rcontinue\15<leader>cC\1\0\3\vnormal\n<C-h>\rvariants\0\rterminal\n<C-h>\21command_variants\1\0\3\fverbose\14--verbose\vresume\r--resume\rcontinue\15--continue\bgit\1\0\1\17use_git_root\2\frefresh\1\0\4\23show_notifications\2\19timer_interval\3è\a\15updatetime\3d\venable\2\vwindow\1\0\6\fcommand\vclaude\21command_variants\0\fkeymaps\0\vwindow\0\frefresh\0\bgit\0\1\0\5\rposition\rbotright\16split_ratio\4³æÌ™\3³æÌþ\3\20hide_signcolumn\2\17hide_numbers\2\17enter_insert\2\nsetup\16claude-code\frequire\0", "config", "claude-code.nvim")
time([[Config for claude-code.nvim]], false)
-- Config for: wiki.nvim
time([[Config for wiki.nvim]], true)
try_loadstring("\27LJ\2\nj\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\14wiki_file\t<cr>\tpath\f~/wiki/\14wiki_open\15<leader>ww\nsetup\twiki\frequire\0", "config", "wiki.nvim")
time([[Config for wiki.nvim]], false)
-- Config for: ts-error-translator.nvim
time([[Config for ts-error-translator.nvim]], true)
try_loadstring("\27LJ\2\nR\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rauto_cmd\2\nsetup\24ts-error-translator\frequire\0", "config", "ts-error-translator.nvim")
time([[Config for ts-error-translator.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd render-markdown.nvim ]]

-- Config for: render-markdown.nvim
try_loadstring("\27LJ\2\n×\1\0\0\a\0\f\1\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\0039\3\t\3'\5\n\0'\6\v\0B\3\3\0?\3\0\0B\0\2\1K\0\1\0\fvimwiki\rmarkdown\rregister\rlanguage\15treesitter\bvim\15file_types\1\0\1\15file_types\0\1\4\0\0\rmarkdown\fvimwiki\vAvante\nsetup\20render-markdown\frequire\3€€À™\4\0", "config", "render-markdown.nvim")

time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
