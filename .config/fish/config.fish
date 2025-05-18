export PATH="$HOME/.cargo/bin:$PATH"

set -Ux PATH $PATH /usr/local/share/dotnet
set -Ux DOTNET_ROOT /usr/local/share/dotnet

abbr -a e nvim
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'

abbr -a cl 'claude'	
abbr -a cc 'claude --continue'
abbr -a cld 'claude --continue --dangerously-skip-permissions'

# Dotfiles management
abbr -a dotfiles 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

abbr -a d docker
abbr -a dc "docker compose"
abbr -a dcf "docker compose -f docker-compose.yml"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza --icons'
	abbr -a ll 'eza -l --icons'
	abbr -a lll 'eza -la --icons'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end


set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3
# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underl

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

# pnpm
set -gx PNPM_HOME "/Users/bekirisgor/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/bekirisgor/miniconda/bin/conda
    eval /Users/bekirisgor/miniconda/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/bekirisgor/miniconda/etc/fish/conf.d/conda.fish"
        . "/Users/bekirisgor/miniconda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/bekirisgor/miniconda/bin" $PATH
    end
end
# <<< conda initialize <<<


# Created by `pipx` on 2024-08-09 03:14:14
set PATH $PATH /Users/bekirisgor/.local/bin


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/bekirisgor/.cache/lm-studio/bin
eval "$(/opt/homebrew/bin/brew shellenv)"
