eval "$(/opt/homebrew/bin/brew shellenv)"

 export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
 export EDITOR='subl -w'

export PATH="$PATH:/Users/mazentech/.dotnet/tools"

# Added by `rbenv init` on Sat 21 Sep 2024 22:48:54 +03
eval "$(rbenv init - --no-rehash zsh)"

# Add .NET Core SDK tools
export PATH="$PATH:/Users/mazentech/.dotnet/tools"

export JAVA_HOME=$(/usr/libexec/java_home)
