# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###################################### MY ########################################
alias grep='grep --color=always'

####################################### LS ############################################
alias l='ls --color=always'
alias l.='ls -d .*'
alias ll='ls -lhrt --color=always'
alias lla='ls -lhrta --color=always'
alias lld='ls -lUd */ --color=always'
alias la='ls -a --color=always'

######################################## CD ########################################
alias bd='cd "$OLDPWD"' # equivalent to : cd -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cdd='cd ~/Documents'
alias cdtd='cd ~/Documents/ADAPT-LAB/tesi-dagostino/trunk'
alias cdtb='cd ~/Documents/ADAPT-LAB/tesi-bruzzone/trunk/jss24/submission'

######################################## GIT ########################################
alias gstatus='git status -sb'
alias glog='git log --oneline'
alias glast='git log -1 HEAD --stat'
alias gdiff='git diff'

alias gremote='git remote -v'
alias gbranch='git branch -va'
alias gfetchupstream='git fetch upstream'
alias gmergeupstream='git merge upstream/main'
alias gfetchorigin='git fetch origin'
alias gmergeorigin='git merge origin/main'
alias gcheckoutmain='git checkout main'

alias gpull='git pull'
alias gadd='git add'
alias gadda='git add --all'
alias gcommit='git commit -s'
alias gcommitm='git commit -sm'
alias gpush='git push'
alias gpushf='git push --force'

alias gclearcache='git rm -r --cached .'

alias gitammendall='git add --all && git commit --amend --no-edit && git push --force'

######################################## SVN ########################################
export SVN_EDITOR=nvim

######################################## FAST ########################################
alias v='nvim'
alias v.='nvim .'
alias c='clear'
alias h='history'
alias ee='exit'
alias code.='code . && exit'
alias cp='cp -r'
alias rmhistory='rm ~/.bash_history'

######################################## FUNCTIONS and USEFULL ALIAS ########################################
extract() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xvjf "$1" ;;
    *.tar.gz) tar xvzf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.tar.xz) tar xvJf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xvf "$1" ;;
    *.tbz2) tar xvjf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *.xz) unxz "$1" ;;
    *.exe) cabextract "$1" ;;
    *) echo "'$1': unrecognized file compression" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

alias gcollect="find ~ -xdev \( -type f \( -name .DS_Store -o -name .directory -o -name ._.DS_Store -o -name logfile.wget -o -name core -o -name Thumbs.db -o -name \*.bck -o -name .\*.bck -o -iname .\*.bak -o -name .\*~ -o -name \*.o -o -name \*.ilg -o -name \*.nav -o -name \*.snm -o -name \*.vrb -o -name \*.log -o -name \*.blg -o -name \*.bcf -o -name \*-blx.bib -o -name \*.run.xml -o -name \*.synctex.gz -o -name \*.aux -o -name a.out -o -name DEADJOE -o -name \*~ -o -iname \*.bak -o -name \*.crashdump -o -name erl_crash.dump -o -name \*.fls -o -name \*.fdb_latexmk -o -name %tmp%\* \) \) -exec rm -fv {} \;"

alias gnvim="goneovim"
alias gn="goneovim"

# ==================rust==================
source "$HOME/.cargo/env"
# . "$HOME/.cargo/env"

# ==================scala=================
export PATH="/usr/local/opt/scala@2.13/bin:$PATH"
export SCALA_HOME="$HOMEBREW_PREFIX/opt/scala@2.13/idea"

# ==================java==================
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home" # /usr/local/Cellar/openjdk/21.0.1/libexec/openjdk.jdk/Contents/Home
# export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
# export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
# export PATH="/usr/local/opt/openjdk/bin:$PATH" # 21
jhome () {
  unset JAVA_HOME
  export JAVA_HOME=`/usr/libexec/java_home -v $@`
  export PATH=$JAVA_HOME/bin:$PATH
  echo "JAVA_HOME:" $JAVA_HOME
  echo "java -version:"
  java -version
}
alias j21="jhome 21" # "export JAVA_HOME=`/usr/libexec/java_home -v 21`; java -version"
alias j17="jhome 17" # "export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
alias j11="jhome 11" # "export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"

# ==================C=================
# export C_INCLUDE_PATH="/Applications/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.11.3.rel1.macos64_1.1.0.202305231506/tools/arm-none-eabi/include"
# === gcc ===
alias gcc='gcc-13'

# ==================C++=================
# export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"
# export CPPFLAGS="-I/usr/local/opt/openjdk@17/include"
# === g++ ===
alias g++='g++-13'

# ==================STM32=================
alias stm32cubeide='/Applications/STM32CubeIDE.app/Contents/MacOS/STM32CubeIDE &'
alias STM32_Generate_Compile_Commands='bear -- make -j8 all -C ./Debug/'
export PATH="$PATH:/Applications/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.11.3.rel1.macos64_1.1.0.202305231506/tools/bin"

STM32_Clean_Rel () {
    make -j8 clean -C ./Release
}

STM32_Compile_Rel () {
    make -j8 all -C ./Release
}

STM32_Clean () {
    make -j8 clean -C ./Debug
}

STM32_Compile () {
    make -j8 all -C ./Debug
}

STM32_Generate_Make() { # $1 is the project name or all
    /Applications/STM32CubeIDE.app/Contents/MacOS/STM32CubeIDE -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data . -build "$1"
}

STM32_Flash() { # $1 is the path to the elf file
    /Applications/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.macos64_2.1.0.202305091550/tools/bin/STM32_Programmer_CLI -c port=swd -w "$1" -rst
}

# ==================ocaml=================
eval $(opam env)

# ==================latex===========

alias clearlatex='rm -rf *.spl *.aux *.log *.out *.toc *.bbl *.blg *.synctex.gz *.fdb_latexmk *.fls *.lot *.lof *.gz *.idx *.ilg *.ind'
export BIBINPUTS=$HOME/texmf/tex/latex/adapt-lab/adapt-lab/trunk/bibs:.

l4p() {  # it assumes to have $BIBINPUTS set and with the dir to look into as the first one
  BIB_DIR=${BIBINPUTS%%:*}
  grep -rin"$2" -ie "$1" "$BIB_DIR"/*.bib
}

vimbib() { # it assumes to have $BIBINPUTS set and with the dir to look into as the first one
  BIB_DIR=${BIBINPUTS%%:*}
  # local bibs=()
  # for bib in "$@"
  # do
  #    bibs+=($BIB_DIR/"$bib"".bib")
  # done
  local bibs=($@)
  bibs=("${bibs[@]/%/.bib}")
  bibs=( "${bibs[@]/#/$BIB_DIR/}" )
  echo "${bibs[@]}"

  vim -p "${bibs[@]}"
}

# ==================pkg-config===========
# export PKG_CONFIG_PATH=~/TMP/td/build/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/Users/federicobruzzone/lib/tdlib/lib/pkgconfig/:$PKG_CONFIG_PATH

# ==================dyld===========
# export DYLD_LIBRARY_PATH=/Users/federicobruzzone/TMP/tdlib/lib/:$DYLD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=/Users/federicobruzzone/lib/tdlib/lib/:$DYLD_LIBRARY_PATH

# ==================telegram===========
export API_HASH="a3406de8d171bb422bb6ddf3bbd800e2"
export API_ID="94575"

# MACOS info
# /Library/Developer/CommandLineTools

# ==================yabai===========
# yabai --stop-service; yabai --start-service;

# ==================skhd===========
# skhd --stop-service; skhd --start-service;

# ==================starship===========
# export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init bash --print-full-init)"

