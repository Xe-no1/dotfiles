# Zsh plugins directory
ZPLUGINDIR=$HOME/.config/zsh/zsh-plugins

autoload -Uz $ZDOTDIR/functions/plugin-clone
autoload -Uz $ZDOTDIR/functions/plugin-source
autoload -Uz $ZDOTDIR/functions/zcompile-many
autoload -Uz $ZDOTDIR/functions/plugin-clean

# Make a github repo plugins list, to be appended to the `plugin-clone` function
repos=(
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-completions
  Aloxaf/fzf-tab
  romkatv/powerlevel10k
  jirutka/zsh-shift-select
  Xe-no1/mac-zsh-completions
)

# Actual plugins to be loaded, to be appended to the `plugin-source` and `plugin-clean` functions
plugins=(
  zsh-shift-select
  zsh-syntax-highlighting
  zsh-completions
  mac-zsh-completions
  fzf-tab
  powerlevel10k
)

plugin-clone $repos

# Compiling functions to `.zwc`
[[ $ZDOTDIR/functions/plugin-clone.zwc -nt $ZDOTDIR/functions/plugin-clone ]] || zcompile-many $ZDOTDIR/functions/plugin-clone
[[ $ZDOTDIR/functions/plugin-source.zwc -nt $ZDOTDIR/functions/plugin-source ]] || zcompile-many $ZDOTDIR/functions/plugin-source
[[ $ZDOTDIR/functions/plugin-clean.zwc -nt $ZDOTDIR/functions/plugin-clean ]] || zcompile-many $ZDOTDIR/functions/plugin-clean
[[ $ZDOTDIR/functions/zcompile-many.zwc -nt $ZDOTDIR/functions/zcompile-many ]] || zcompile-many $ZDOTDIR/functions/zcompile-many
[[ $ZDOTDIR/functions/cd.zwc -nt $ZDOTDIR/functions/cd ]] || zcompile-many $ZDOTDIR/functions/cd

# Activate Powerlevel10k Instant Prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugin-source $plugins
source $ZDOTDIR/.p10k.zsh
plugin-clean $repos

# Enable the "new" completion system (compsys).
ZSH_COMPDUMP="$HOME/.cache/zsh"
# Create the parent directory if it doesn't exist
[[ -d $ZSH_COMPDUMP ]] || mkdir -p $ZSH_COMPDUMP
autoload -Uz compinit
compinit -C -d "$ZSH_COMPDUMP/.zcompdump"

# Compiling static init files, such as the `.zshrc`
[[ $ZSH_COMPDUMP/.zcompdump.zwc -nt $ZSH_COMPDUMP/.zcompdump ]] || zcompile-many $ZSH_COMPDUMP/.zcompdump
[[ $ZDOTDIR/.zprofile.zwc  -nt $ZDOTDIR/.zprofile  ]] || zcompile-many $ZDOTDIR/.zprofile
[[ $ZDOTDIR/.zshrc.zwc     -nt $ZDOTDIR/.zshrc     ]] || zcompile-many $ZDOTDIR/.zshrc
[[ $ZDOTDIR/.p10k.zsh.zwc  -nt $ZDOTDIR/.p10k.zsh  ]] || zcompile-many $ZDOTDIR/.p10k.zsh

# Remove right prompt padding
ZLE_RPROMPT_INDENT=0

# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# History
HISTSIZE=10000
HISTFILE=$ZSH_COMPDUMP/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Options
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
setopt inc_append_history
setopt interactive_comments
zle_highlight=('paste:none')

LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.dll=00;93:*.zwc=00;93:';
export LS_COLORS

# Completion styling
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:complete:*:argument-rest' sort false
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_COMPDUMP/.zcompdump"
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height=50%
zstyle ':fzf-tab:complete:fastfetch:*' fzf-flags --margin=0,43,0,0 --height=50% --border
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':completion:*' ignored-patterns '.|..|.DS_Store|**/.|**/..|**/.DS_Store|.Trash|**/.Trash|~/.Trash'
zstyle ':completion:*' ignore-parents 'parent pwd directory'

# Fzf options
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:reverse,bg:-1,bg+:-1
  --color=hl:#5f87af,hl+:#5f87af,info:#EBCB8B,marker:#87ff00
  --color=prompt:#b48ead,spinner:#2E3440,pointer:#a3be8c,header:#8FBCBB
  --color=gutter:#2E3440,border:#D8DEE9,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="❯ "
  --marker="" --pointer="" --separator="─" --scrollbar="│"
  --margin=0,100,0,0 --height=50% --border
  --layout="reverse" --info="right"'

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .DS_Store --exclude .Trash"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .DS_Store --exclude .Trash"

# zsh-syntax-highlighting options
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#4c566a'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
ZSH_HIGHLIGHT_STYLES[commandseperator]='none'
ZSH_HIGHLIGHT_STYLES[arithmetic-expantion]='none'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue'
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[globbing]='none'

# Aliases
alias ls="eza --group-directories-first --all --color=always"
alias cat='bat --color=always'
alias icat='kitten icat'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Set window title to CWD
echo -n -e "\033]0;$(pwd | grep -oE '[^/]+$' || echo "Macintosh HD")\007"
autoload -Uz $ZDOTDIR/functions/cd
