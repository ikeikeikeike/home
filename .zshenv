# for debug
# zmodload zsh/zprof && zprof


# Archi & Distribution
if [ -x /usr/bin/uname ] || [ -x /bin/uname ]; then
  case "`uname -sr`" in
    FreeBSD*);    export ARCHI="freebsd" ;;
    Linux*);      export ARCHI="linux"   ;;
    CYGWIN*);     export ARCHI="cygwin"  ;;
    IRIX*);       export ARCHI="irix"    ;;
    OSF1*);       export ARCHI="osf1"    ;;
    Darwin*);     export ARCHI="darwin"  ;;
    *);           export ARCHI="dummy"   ;;
  esac
  if [ -f /etc/redhat-release ]; then
    case "`cat /etc/redhat-release`" in
      *CentOS*);  export DISTRIBUTE="centos" ;;
      *Red*);     export DISTRIBUTE="redhat" ;;
      *);         export DISTRIBUTE="dummy" ;;
    esac
  else
    case "`uname -v`" in
      *-Ubuntu*); export DISTRIBUTE="ubuntu" ;;
      *);         export DISTRIBUTE="dummy"  ;;
    esac
  fi
else
  export ARCHI="dummy"
  export DISTRIBUTE="dummy"
fi

if [ ! $reattach_to_user_namespace ] && [ $ARCHI = darwin ]; then
  export reattach_to_user_namespace=1
fi

# HOST
if [ -x /bin/hostname ]; then
  export HOST=`hostname`
fi;
export host=`echo $HOST | sed -e 's/\..*//'`


######## path
#
#
#
typeset -gx -U PATH
typeset -gx -U FPATH
#
#
#
# extra
export MANPATH=/usr/share/man:/usr/X11/man:$MANPATH

# extra
export PATH=$HOME/bin:$HOME/sbin:$PATH
export MANPATH=$HOME/share/man:$MANPATH


if [ $ARCHI = darwin ]; then
  export LANG=ja_JP.UTF-8
  export LC_ALL=ja_JP.UTF-8

  export MANPATH=/Developer/usr/share/man:$MANPATH
  export MANPATH=/opt/local/man:$MANPATH
  export PATH=/Developer/usr/bin/:/opt/local/lib/mysql5/bin:$PATH
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export PATH=/usr/local/luajit/bin/:$PATH
  export BOOST_ROOT=$HOME/include/boost:/opt/local/include/boost:$BOOST_ROOT

  export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
  export DISPLAY=:0.0
  export MAKEOPTS="-j4"

  export C_INCLUDE_PATH=/opt/local/include:$C_INCLUDE_PATH
  export CPLUS_INCLUDE_PATH=/opt/local/include:$HOME/include:$CPLUS_INCLUDE_PATH
  unset DYLD_LIBRARY_PATH
  unset LD_LIBRARY_PATH
fi
if [ $ARCHI = linux ]; then
  export LANG=en_US.UTF-8
  export EDITOR="vim"
  export MAKEOPTS="-j12"
fi

export PATH=/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH


# begin cofigures
#
#
# use the same Emacs keybind
bindkey -e
limit coredumpsize 10240000

# Report show detail a processing if passed over 5 seconds.
REPORTTIME=5

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least


# less
export LESSCHARSET=utf-8
export PAGER='less'
export LESS='--tabs=4 -q --no-init --LONG-PROMPT --ignore-case -R '
export LESSOPEN='| src-hilite-lesspipe.sh %s'

# Docker
export DOCKER_HOST=tcp://localhost:4243

# gsutil
export PATH=$PATH:$HOME/lib/gsutil


### zsh

export FPATH=~/.zsh-completions_ext:$FPATH


### PHP ###

if [[ -s "$HOME/.phpenv/bin/phpenv" ]]; then
    export PATH="$HOME/.phpenv/bin:$PATH"
fi


### ruby ###

if [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
    # This loads rbenv
    export RBENV_ROOT=$HOME/.rbenv
    export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)"
    export RUBY_EXE=`rbenv which ruby`
elif [[ -s "/usr/local/bin/rbenv" ]]; then
    export RBENV_ROOT=/usr/local/opt/rbenv
fi


### perl ###

if [[ -s $HOME/perl5/perlbrew/bin/perlbrew ]]; then

    source $HOME/perl5/perlbrew/bin/perlbrew

elif [[ -s $HOME/.plenv/bin/plenv ]]; then

    export PLENV_ROOT=$HOME/.plenv
    export PATH=$PLENV_ROOT/bin:$PATH
    eval "$(plenv init -)"

fi

### java ###

# export JAVA_HOME="/Library/Internet\ Plug-ins/JavaAppletPlugin.plugin/Contents/Home"
if [[ -s "/usr/libexec/java_home" ]]; then
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    export JAVA=$JAVA_HOME/bin
    export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk
    alias javac='javac -J-Dfile.encoding=UTF-8'
    alias java='java -Dfile.encoding=UTF-8'
    alias jdb='jdb -J-Dfile.encoding=UTF-8'
fi

### scala ###

# export REBEL_HOME=/usr/local/share/jrebel
# export PATH=$REBEL_HOME/bin:$PATH
# export PLAY_HOME=/usr/local/share/play
# export PATH=$PLAY_HOME:$PATH
# alias sbt='JAVA_OPT="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256m -Xmx512M -Xss2M" sbt'
export SBT_OPTS="-Xmx2048m -Xms1024m -Xss128m -Dfile.encoding=UTF8"

## #nodejs ###

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
fi

### haskell ###

export CABAL_HOME=~/.cabal
export PATH=$CABAL_HOME/bin:$PATH
export MANPATH=$CABAL_HOME/share:$MANPATH


### golang ###
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
    source "$HOME/.gvm/scripts/gvm"
fi

eval "$(direnv hook zsh)" 2> /dev/null

### Elixir
if [[ -s "$HOME/.exenv/bin" ]]; then
    export PATH="$HOME/.exenv/bin:$PATH"; eval "$(exenv init -)"
fi


### Dart Flutter

export PATH=$PATH:/usr/lib/dart/bin
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/.virtualenvs/flutter/sdk/flutter/bin


### python ###

# if pythonbrew < not use
#[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

# path
export PATH=$PYTHON_HOME/bin:$PATH
export MANPATH=$PYTHON_HOME/share/man:$MANPATH

# python settings
export PYTHONIOENCODING=UTF-8

# Import virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
# virtualenvwrapper
if [ -f `\which virtualenvwrapper.sh 2> /dev/null` ]; then
  source virtualenvwrapper.sh 2> /dev/null
fi

## extra virtualenv
# require
export PIP_REQUIRE_VIRTUALENV=false
# require distribure
export VIRTUALENV_USE_DISTRIBUTE=true
# cached download package
export PIP_DOWNLOAD_CACHE=$HOME/.pip_cache
# package in virtualenv sandbox.
export PIP_RESPECT_VIRTUALENV=true
# Tell pip to create its virtualenvs in $WORKON_HOME.
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PYTHONSTARTUP=$HOME/.pythonrc.py
export VIRTUAL_ENV_PYTHON_LIB=$VIRTUAL_ENV/lib

### extra ###

# zsh autojump
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    export FPATH="/opt/local/share/zsh/site-functions:$FPATH"
    . /opt/local/etc/profile.d/autojump.zsh
fi
if [ -f /usr/share/autojump/autojump.zsh ]; then
    export FPATH="/usr/local/share/zsh/site-functions:$FPATH"
    . /usr/share/autojump/autojump.zsh
fi
if [[ -s /usr/local/bin/brew ]]; then
    if [[ -s $(/usr/local/bin/brew --prefix)/etc/profile.d/autojump.sh ]]; then
        . $(/usr/local/bin/brew --prefix)/etc/profile.d/autojump.sh
    fi
fi
if [[ -s /root/.autojump/etc/profile.d/autojump.sh ]]; then
    source /root/.autojump/etc/profile.d/autojump.sh
fi

# mysettings
source $HOME/.adds_zshenv 2> /dev/null

export ODBCINI=/etc/odbc.ini
export ODBCSYSINI=/etc
export FREETDSCONF=/etc/freetds.conf

# zplug: # git clone https://github.com/zplug/zplug $ZPLUG_HOME
export ZPLUG_HOME=~/.zplug


# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000000
SAVEHIST=10000000



# end
#
#
#
