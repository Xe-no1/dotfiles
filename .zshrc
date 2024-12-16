# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_WINDOW_TITLE_DIRECTORY_DEPTH=1

# function to set terminal title
function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

eval "$(rbenv init - zsh)"

ZLE_RPROMPT_INDENT=0

export PATH="/usr/local/share/dotnet:$PATH"
export PATH="/Users/mazentech/.cargo/bin:$PATH"
export PATH="/opt/homebrew/bin/kitten:$PATH"

# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -U compinit; compinit

# Add in zsh plugins, plugins location: "~/.local/share/zinit/plugins/z-shell"
#zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice wait lucid
zinit light Aloxaf/fzf-tab
#zinit ice wait lucid
#zinit light marlonrichert/zsh-autocomplete
zinit ice wait lucid
zinit light z-shell/F-Sy-H
zinit ice wait lucid
zinit light zsh-users/zsh-completions
zinit ice wait lucid
zinit light olets/zsh-window-title

#source /Users/mazentech/completion.zsh

# Add in snippets
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait lucid
zinit snippet OMZP::git
zinit ice wait lucid
zinit snippet OMZP::sudo
zinit ice wait lucid
zinit snippet OMZP::archlinux
zinit ice wait lucid
zinit snippet OMZP::aws
zinit ice wait lucid
zinit snippet OMZP::kubectl
zinit ice wait lucid
zinit snippet OMZP::kubectx
zinit ice wait lucid
zinit snippet OMZP::command-not-found

zinit cdreplay -q

zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload'_history_substring_search_config'

# ~/.zshrc
#export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
#zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
#source <(carapace _carapace)

# Make OMP skip running on Apple Terminal only
#if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  #eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ompconf.json)"
#fi

#export LANG="en_GB.UTF-8"
#export LC_ALL="en_GB.UTF-8"

# Keybindings
bindkey -M emacs "^X" _complete_help
bindkey '^U' history-search-backward
bindkey '^J' history-search-forward
#bindkey '^H' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Options
setopt AUTO_MENU
setopt globdots
setopt no_list_types
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt correct
setopt extendedglob
setopt nocaseglob
setopt rcexpandparam
setopt nocheckjobs
setopt autocd
setopt inc_append_history

# Setting "LS_COLORS"'s colors and setting the lessfilter
#zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
#export LESSOPEN='|~/.lessfilter %s'
export LS_COLORS="$LS_COLORS:di=0;96:fi=0:pi=0;92:ln=0;93:ex=0:ln=0;93:or=0;31:mi=0;31:*.jpg=0;95:*.png=0;95:"

export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# Completion styling
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:complete:*:argument-rest' sort false
zstyle ':completion:*' menu yes
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' fzf-flags --height 97%
#zstyle ':fzf-tab:complete:-command-:*' fzf-preview 'tldr --color=always $word'

# Fzf options
#--preview="if [[ {} =~ ('.jpg'|'.JPG'|'.jpeg'|'.png'|'.PNG')$ ]]; then gls -1 -a --color --group-directories-first {}; elif [ -d {} ]; then gls -1 -a --color=always --group-directories-first -H {}; else bat --color=always {}; fi"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --height 96%
  --ansi
  --color=fg:-1,fg+:-1,bg:-1,bg+:#353535
  --color=hl:#5fd7ff,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#ba8baf,spinner:#1e1e1e,pointer:#ba8baf,header:#87afaf
  --color=border:#f8f8f8,label:#aeaeae,query:#FFFFFF
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1"
  --prompt="❯ " --marker="" --pointer="❯" --separator="─"

  --scrollbar="│" --layout="reverse" --info="right"'

# Aliases
alias ls-old='ls'
alias ls="gls -1 -A --color --group-directories-first"
alias edit='nvim'
alias fetch='fastfetch --show-errors'
alias fastfetch='fastfetch --show-errors'
#alias cat -i='chafa '
#alias cat='bat --color=always'
#alias c="printf '\e[2J\e[3J\e[H'"
#alias clear="printf '\e[2J\e[3J\e[H'"
alias c="clear"
alias python="python3"
alias pip="pip3"
alias sudo='sudo '

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias tf)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
