autoload -U colors ; colors
local DEFAULT=%{$reset_color%}
local RED=%{$fg[red]%}
local GREEN=%{$fg[green]%}
local YELLOW=%{$fg[yellow]%}
local BLUE=%{$fg[blue]%}
local PURPLE=%{$fg[purple]%}
local CYAN=%{$fg[cyan]%}
local WHITE=%{$fg[white]%}




# -------------------------------------
# 補完機能
# -------------------------------------

# 補完機能の強化
autoload -U compinit
compinit

#補完に関するオプション
setopt auto_param_slash      # ディレクトリ�完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル�尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル�語ファイル�完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ

setopt list_packed           # リストを詰めて表示

bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)

# 補完候補を ←↓↑→ でも選択出来るようにする
zstyle ':completion:*:default' menu select=2

# 補完関数の表示を過剰にする編
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'

# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

#LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt correct

SPROMPT="correct: $RED%R$DEFAULT => $GREEN%r$DEFAULT ? [Y/N/A/E]"

bindkey -v

# Ghostty CSI u モードのキーバインド
bindkey '^[[27;2;13~' self-insert  # Shift+Enter で改行挿入


alias -s py=python


# -------------------------------------
# prompt settings (Starship)
# -------------------------------------

zstyle "completion:*" use-cache true
zstyle "completion:*" list-separator "==>"

# Starshipを使用（Warp Terminal以外）
if [[ "$TERM_PROGRAM" != "WarpTerminal" ]]; then
    eval "$(starship init zsh)"
fi

alias vi="vim"


if [[ -z "$TMUX" && $- == *l* && "$TERM_PROGRAM" != "WarpTerminal" ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

export PATH=$PATH:/Users/$(whoami)/Library/Android/sdk/platform-tools
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"  
export PATH=$PATH:/Users/$(whoami)/dotfiles/
export ANDROID_HOME=/Users/$(whoami)/Library/Android/sdk/  
export LANG=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.3.2/Contents/Home/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.3.2/Contents/Home


# Load Angular CLI autocompletion if available.
if command -v ng >/dev/null 2>&1; then
    source <(ng completion script)
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/m1zyuk1/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

[[ -s "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Added by Antigravity
export PATH="/Users/m1zyuk1/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity
export PATH="/Users/m1zyuk1/.antigravity/antigravity/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/Users/m1zyuk1/Projects/name/.gopath/bin:$PATH"
