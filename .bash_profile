export BASH_SILENCE_DEPRECATION_WARNING=1

# Set path so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

. "$HOME/.cargo/env"
# export PATH="/usr/local/opt/scala@2.13/bin:$PATH"
# export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

