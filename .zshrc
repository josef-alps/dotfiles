# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=en_US.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1

bindkey -v              # キーバインドをviモードに設定
bindkey -M viins 'jj' vi-cmd-mode

setopt PROMPT_SUBST
#PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '
PROMPT='%F{blue}%~%f%# '
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
#setopt correct           # コマンドのスペルを訂正する
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
#setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

precmd () {
  psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"

## プロンプトに色を付ける
#autoload -U colors; colors
## 一般ユーザ時
#tmp_prompt="%F{cyan}[%n@%D{%m/%d %T}]%f%1(v|%F{green}%1v%f|) "
##tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%} %1(v|%F{green}%1v%f|)"
#tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
#tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
#tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
#
## rootユーザ時(太字にし、アンダーバーをつける)
#if [ ${UID} -eq 0 ]; then
#  tmp_prompt="%B%U${tmp_prompt}%u%b"
#  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
#  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
#  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
#fi
#
#PROMPT=$tmp_prompt    # 通常のプロンプト
#PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#RPROMPT=$tmp_rprompt  # 右側のプロンプト
#SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
## SSHログイン時のプロンプト
#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
#;

#Title
# precmd() {
#     [[ -t 1 ]] || return
#     case $TERM in
#         *xterm*|rxvt|(dt|k|E)term)
#         print -Pn "\e]2;[%~]\a"
# 	;;
#         # screen)
#         #      #print -Pn "\e]0;[%n@%m %~] [%l]\a"
#         #      print -Pn "\e]0;[%n@%m %~]\a"
#         #      ;;
#     esac
# }

# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###

# lsしたときls -llにする
alias ll='ls -alF'
alias gs='git status'
alias ts='tig status'
alias ga='git add'
alias gl='git log'
alias bys='cd /Users/a13232/monaco-web;grunt nodemon;'
alias nl='npm list --depth=0 -g'
alias chrome='/Applications/Google\ Chrome.app/Contents/Macos/Google\ Chrome'
#alias r='ranger --choosedir=/tpm/.rangerdir; LASDIR=`cat /tmp/.rangerdir`; cd "$LASTDIR"'
alias r='source ranger'
alias vim='nvim'
alias open='explorer.exe'
alias gitlog='git log --graph --name-status --pretty=format:"%C(red)%h %C(green)%an %C(Cyan)%ad %Creset%s %C(yellow)%d%Creset"'
export DISPLAY="$(ipconfig.exe | awk -v RS='\r\n' '/IPv4/{ ip=$NF } /255\.255\.0\.0/{ print ip; exit }'):0"

# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls -ll;
}

# suffix alias
setopt auto_cd
alias -s html='google-chrome'
alias -s {md,markdown,txt}='vim'

#export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/wsl/bin:$PATH
export PATH=$HOME/.config/zsh:$PATH
fpath=(~/.config/zsh $fpath)

# export Go env settings
export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:/mnt/c/Program\ Files/Google/Chrome/Application/

# fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
export FZF_COMPLETION_TRIGGER=','
typeset -Tgx FZF_DEFAULT_OPTS fzf_default_opts " " 
fzf_default_opts=(
  '--height=90%'
  '--reverse'
  '--border'
  '--inline-info'
  '--prompt="➜  "'
  '--margin=0,2'
  '--tiebreak=index'
  '--no-mouse'
  '--filepath-word'
)

() {
  local -A color_map=(
    [fg]='-1'
    [bg]='-1'
    [hl]='33'
    [fg+]='250'
    [bg+]='235'
    [hl+]='33'
    [info]='37'
    [prompt]='37'
    [pointer]='230'
    [marker]='230'
    [spinner]='37'
  )

  for x in "${(k)color_map[@]}"; do
    fzf_color_opts+=("${x}:${color_map[${x}]}") 
  done
  fzf_default_opts+=( '--color="'"${(j.,.)fzf_color_opts}"'"' )
}

() {
  local -a fzf_bind_opts=()
  local -A bind_map=(
    [?]='toggle-preview'
    [ctrl-a]='toggle-all'
    ['ctrl-]']='replace-query'
    [ctrl-w]='backward-kill-word'
    [ctrl-x]='jump'
    [ctrl-z]='ignore'
    [up]='preview-page-up'
    [down]='preview-page-down'
  )

  for x in "${(k)bind_map[@]}"; do
    fzf_bind_opts+=("${x}:${bind_map[${x}]}")
  done
  fzf_default_opts+=( '--bind="'"${(j:,:)fzf_bind_opts}"'"' )
}

export FZF_CTRL_T_COMMAND="fd -i -L --hidden --type f "
export FZF_CTRL_T_OPTS="
    --select-1 --exit-0
    --bind 'ctrl-s:execute(tmux splitw -v -- nvim {})'
    --bind 'ctrl-v:execute(tmux splitw -h -- nvim {})'
    --bind 'ctrl-n:execute(tmux new-window -- nvim {})'
    --bind '>:reload($FZF_ALT_C_COMMAND -H -E .git)'
    --bind '<:reload($FZF_ALT_C_COMMAND)'
    --preview 'bat -r :100 --color=always --style=header,grid {}'"


fzf-ripgrep-widget() {
  LBUFFER="${LBUFFER}$(__fzf_ripgrep)"
  local ret=$?
  zle reset-prompt
  return $ret
}

__fzf_ripgrep() {
  emulate -L zsh
  rg_cmd="rg --smart-case --ignore-case --hidden --line-number --color=always --trim --follow" 
  selected=$(FZF_DEFAULT_COMMAND=":" \
      fzf --bind="change:top+reload($rg_cmd {q} || true)" \
          --bind="ctrl-s:execute(tmux splitw -v -- nvim +/{q} {1} +{2})" \
          --bind="ctrl-v:execute(tmux splitw -h -- nvim +/{q} {1} +{2})" \
          --bind="ctrl-n:execute(tmux splitw -n -- nvim +/{q} {1} +{2})" \
          --ansi --phony \
          --delimiter=":" \
          --preview="bat -H {2} --color=always --style=header,grid {1}" \
          --preview-window='down:60%:+{2}-10')

  local ret=$?
  [[ -n "$selected" ]] && echo ${${(@s/:/)selected}[1]}
  return $ret
}

autoload -Uz fzf-ripgrep-widget
zle -N fzf-ripgrep-widget
bindkey "^h" fzf-ripgrep-widget

fdd() {
  local dir
  dir=$(fd -L -i --hidden --type d 2> /dev/null | fzf-tmux +m) &&
  cd "$dir"
}
