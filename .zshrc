alias ll='ls -l'
alias la='ls -la'
alias vi='vim'
alias rm='rm -i'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gl='git log --color'
alias gd='git diff --color'
alias gpf='git push --force-with-lease'

alias ippei='curl https://gist.githubusercontent.com/dameninngenn/5865715/raw/timer.pl | perl - --color=green'
alias homo='curl https://gist.githubusercontent.com/s-aska/9268689/raw/26d81dbe17fbd8cfc3984eca6848ced0cf3293bd/homo.pl | perl'

# OSによってlsオプションを分ける
case "${OSTYPE}" in
darwin*)
    alias ls="ls -FG"
    ;;
linux*)
    alias ls="ls --color"
    export LSCOLORS=exfxbxdxcxegedabagacad
   ;;
esac

# /usr/bin より /usr/local/bin を優先する
export PATH=/usr/local/bin:$PATH

export EDITOR=/usr/local/bin/vim

# 日本語
export LANG=ja_JP.UTF-8

bindkey -e

export EDITOR=/usr/bin/vim

# 補完機能
autoload -U compinit
compinit -u

# 移動したディレクトリを記録･･･cd-[Tab]で移動履歴一覧
setopt auto_pushd

# コマンド訂正
setopt correct

# 補完候補を詰めて表示
setopt list_packed

# 補完候補がディレクトリの場合、末尾に / を追加
setopt auto_param_slash

# メールをチェックしない
export MAILCHECK=0
# lsの配色と補完候補の配色を合わせる
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=32' 'bd=46;34' 'cd=43;34'

# 大文字小文字の区別をせずに補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# tab補完で選択できるようにする
zstyle ':completion:*:default' menu select

# set terminal title including current directory
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

# プロンプトの設定
autoload colors
colors
setopt prompt_subst 
PROMPT="[%n] %(?.%{$fg[green]%}.%{$fg[blue]%})%(?!😃  <!😇  ? <)%{${reset_color}%} "
# プロンプト指定(コマンドの続き)
PROMPT2='[%n]> '
# もしかして時のプロンプト指定
SPROMPT="%{$fg[red]%}%{$suggest%}😉  ? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color} "
RPROMPT=$'[ `branch-status-check`%~ ]'


function branch-status-check {
    local prefix branchname suffix
        # .gitの中だから除外
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        branchname=`get-branch-name`
        # ブランチ名が無いので除外
        if [[ -z $branchname ]]; then
            return
        fi
        prefix=`get-branch-status` #色だけ返ってくる
        suffix='%{'${reset_color}'%}'
        echo ${prefix}${branchname} ${suffix}
}

function get-branch-name {
    # gitディレクトリじゃない場合のエラーは捨てます
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
        output=`git status 2> /dev/null`
        if [[ -n `echo $output | grep "^nothing to commit"` ]]; then
            res=':' # status Clean
            color='%{'${fg[green]}'%}'
        elif [[ -n `echo $output | grep "^# Untracked files:"` ]]; then
            res='?:' # Untracked
            color='%{'${fg[yellow]}'%}'
        elif [[ -n `echo $output | grep "^# Changes not staged for commit:"` ]]; then
            res='M:' # Modified
            color='%{'${fg[red]}'%}'
        else
            res='A:' # Added to commit
            color='%{'${fg[cyan]}'%}'
        fi
        # echo ${color}${res}'%{'${reset_color}'%}'
        echo ${color} # 色だけ返す
}

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt share_history

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# おまじない
bindkey -e

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
