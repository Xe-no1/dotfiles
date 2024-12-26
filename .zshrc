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

#export LS_COLORS="$LS_COLORS:di=0;94:fi=0:pi=0;92:ln=0;93:ex=0:ln=0;93:or=0;31:mi=0;31:*.jpg=0;95:*.png=0;95:"
# Setting "LS_COLORS"'s colors and setting the lessfilter
#zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
#export LESSOPEN='|~/.lessfilter %s'
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.dll=00;93:*.zwc=00;93:';
export LS_COLORS

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
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags ${(Q)${(Z:nC:)FZF_DEFAULT_OPTS}}
zstyle ':fzf-tab:*' continuous-trigger '/'
# hide parents
zstyle ':completion:*' ignored-patterns '.|..|.DS_Store|**/.|**/..|**/.DS_Store|.Trash|**/.Trash|~/.Trash'
# hide `..` and `.` from file menu
zstyle ':completion:*' ignore-parents 'parent pwd directory'
#zstyle ':fzf-tab:*' fzf-flags --height 97%
#zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath 2>/dev/null || eza -la --color=always $realpath'
#zstyle ':fzf-tab:complete:-command-:*' fzf-preview 'tldr --color=always $word'

# Fzf options
#--preview="if [[ {} =~ ('.jpg'|'.JPG'|'.jpeg'|'.png'|'.PNG')$ ]]; then gls -1 -a --color --group-directories-first {}; elif [ -d {} ]; then gls -1 -a --color=always --group-directories-first -H {}; else bat --color=always {}; fi"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#434c5e
  --color=hl:#5f87af,hl+:#5f87af,info:#EBCB8B,marker:#87ff00
  --color=prompt:#B48EAD,spinner:#2E3440,pointer:#B48EAD,header:#8FBCBB
  --color=border:#D8DEE9,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="❯ "
  --marker="❯" --pointer="❯" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'

# Aliases
#alias ls-old='ls'
alias ls="eza --color -a"
alias gls="gls --color -a"
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
