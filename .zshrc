#コマンドに応じて補間候補表示
autoload -U compinit
compinit

#####プロンプト関連###################################################################
#プロンプト定義内で!を特殊文字として扱う
#setopt prompt_bang
#プロンプト定義内で%を特殊文字として扱う
setopt prompt_percent
#プロンプト定義内で変数置換やコマンド置換などを扱う
#よく分かってない
#setopt prompt_subst
#プロンプトに色付けを可能にする
autoload -U colors
colors
###PROMPT##########################################################################
#基本のプロンプトの設定
#red green yellow blue cyan
RED="%{${fg[red]}%}"
YELLOW="%{${fg[yellow]}%}"
RESET="%{${reset_color}%}"
PROMPT="${RED}%n@%m ${YELLOW}%~ ${RED}%# ${RESET}"
###PROMPT2#######################################################################
#forやwhileなど複数行の入力時のプロンプト
PROMPT2="${YELLOW} %_ > ${RESET}"
###SPROMPT#######################################################################
#入力ミスを確認する時
SPROMPT="${YELLOW} '%r' ?   [nyae] "
###RPROMPT#######################################################################
#右側プロンプト
RPROMPT="%/"
#変数の処分
unset RED CYAN RESET
#プロンプトのテーマを利用
#autoload promptinit
#-pでプレビュー
#-cでテーマ確認
#promptinit
####################################################################################


# ターミナルのタイトルに「ユーザ@ホスト:カレントディレクトリ」を
# 表示する。
#case "${TERM}" in
#kterm*|xterm*)
#    precmd() {
#        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#    }
#    ;;
#esac 


#####ヒストリー設定関係#####
#存在しないヒストリにビープ音
setopt hist_beep
#zshがセッションを終了した順にファイルに追記
#setopt append_history
#各端末でコマンドを実行した順番にヒストリへ記録
setopt inc_append_history
# !を使ったヒストリ展開を行う
setopt bang_hist
#ヒストリ展開を行ったとき、すぐ実行せず、一度読込む
setopt hist_verify
#ヒストリから関数定義を除く
setopt hist_no_functions
#historyコマンドを記録しない
setopt hist_no_store
#行頭スペースコマンドは記録しない
#setopt histignorespace
#同じコマンド続けて実行,重複記録しない
setopt hist_ignore_dups
#ヒストリ内にまったく同じ行、古い削除、新しい記録
setopt hist_ignore_all_dups
#古いヒストリが削除されるとき
#まったく同じ行があればそれを優先して削除
setopt hist_expire_dups_first
#ファイルに書き出すとき古いコマンドと同じなら無視
#setopt hist_save_no_dups
#実行時間も記録
#書式
#:実行時間:経過時間:コマンド
setopt extended_history
#余分な空白を排除して記録
setopt hist_reduce_blanks
#複数の端末でリアルタイムにヒストリを共有
setopt share_history


##### キーバインド設定 #####
# d default
# e emacs
# v vi
bindkey -d
# シェルの操作はemacsな感じで
# わざわざ記述しておく
bindkey "^A" beginning-of-line                    # 行頭へジャンプ
bindkey "^B" backward-char                        # ←キー
bindkey "^D" delete-char-or-list                  # deleteキー カーソル上の文字を削除
bindkey "^E" end-of-line                          # 行末へジャンプ
bindkey "^F" forward-char                         # →キー
bindkey "^G" send-break                           # コマンド入力を実行せずに無視して次の行へ 
bindkey "^H" backward-char                        # ←キー
bindkey "^I" expand-or-complete                   # 展開または補完
#bindkey "^J" accept-line                         # screen用に使用
bindkey "^K" kill-line                            # カーソルから行末までを削除
bindkey "^L" clear-screen                         # クリアスクリーン
bindkey "^M" accept-line                          # コマンド行のコマンドを実行 Enterの代わりに
#bindkey "^O" accept-line-and-down-history        # 使い(どころ|かた)が分からない
#bindkey "^Q" push-line                           # 使い(どころ|かた)が分からない
bindkey "^R" history-incremental-search-backward  # インクリメンタルサーチ
bindkey "^S" history-incremental-search-forward   # インクリメンタルサーチ
#bindkey "^T" transpose-chars                     # 文字の順番を入れ替える
bindkey "^U" kill-whole-line                      # 一行削除
#bindkey "^V" quoted-insert                       # 文字を挿入 使う必要性がないと思う
bindkey "^W" backward-kill-word                   # カーソルから行頭までを削除

bindkey "^N" history-beginning-search-forward     # 超絶に使う
bindkey "^P" history-beginning-search-backward    # 超絶に使う


#####ディレクトリ関連#####
#cd省略でディレクトリ移動
setopt auto_cd
# ~を必要せずに移動
#setopt cdable_vars
#特に必要がないかと
unsetopt cdable_vars
#cdコマンドでディレクトリスタックに保存
setopt auto_pushd
#ディレクトリスタックに重複して記録しない
setopt pushd_ignore_dups
#移動先がシンボリックリンクならば実際のディレクトリに移動する
setopt chase_links
#パスに..が含まれる シンボリックリンクではなく実際のディレクトリに移動
setopt chase_dots
#引数なしでpushdするとpushd $HOMEとして実行
setopt pushd_to_home


#コマンドのスペル訂正をしてくれる
# y 訂正コマンドを実行
# n 入力したコマンドが実行
# a 実行を中断 abort
# e コマンドライン編集 edit
setopt correct
#引数についてもスペル訂正を試みる
#それは面倒なことになるかも nocorrectをコマンド前
#setopt correct_all
unsetopt correct_all
#スペル訂正時にDVORAK配列を前提にする
#setopt dvorak
unsetopt dvorak


#####補完関係#####
#補完のときプロンプトの位置を変えない
setopt always_last_prompt
#補完候補が複数あるとき自動でメニューをリストアップ
setopt auto_list
#補完要求に対してメニューをリストアップ
setopt auto_menu
#補完候補を詰めて表示する
setopt list_packed
#補完の表示を水平方向に
setopt list_rows_first
#補完候補の表示を親切に ls -F
# /がディレクトリ
# @がシンボリックリンク
setopt list_types
# tabキーの節約
setopt menu_complete
#エイリアスに対して別の補完定義を telnet tt
#setopt complete_aliases
setopt no_complete_aliases
#ディレクトリ 補完 /を付与
setopt auto_param_slash
#スペースで /を削除
setopt auto_remove_slash
#よく分からない
setopt auto_name_dirs
#補完候補表示時にビープ音をならさない
setopt nolistbeep
#先方予測機能を有効に設定する
#autoload predict-on
#predict-on


#ユーザ毎の設定を行う
case ${UID} in
  0)                 #rootユーザの場合

  ;;
  *)                 #一般ユーザの場合

  ;;
esac


#実験的な設定をに書き込んでおく
[ -f ~/.zshrc.lab ] && source ~/.zshrc.lab



#対話的なシェルであることを示す
setopt interactive
#ログインシェルであることを示す
setopt login
#入力されたコマンドラインを再表示する
unsetopt verbose


#ビープ音を鳴らす
setopt beep
#キーバインドをemacsにする
setopt emacs
#キーバインドをviにする
#setopt vi
#zshラインエディタを使用する
setopt zle


#crontabの編集などはvimで
export EDITOR=vim

#変数を定義したら自動的にexport
#環境変数へ
#setopt all_export
unsetopt all_export




#~/.zfunc/dl
#自作関数
autoload -U dl



#ディレクトリ777-022=755
#ファイル    666-022=644
umask 022









#ファイルグロブ機能を使用する
setopt glob
#ファイルグロブで大文字小文字を区別する
setopt case_glob
# =ls which ls
setopt equals
# * に対して.で始まるファイルにもマッチさせる
unsetopt glob_dots
#ファイルグロブでパターンにマッチしないものがあった場合
#エラーを表示してその時点でコマンドを終了する
unsetopt nonomatch
#パターンにマッチしないものがあってもコマンドを実行する
#エラーメッセージは表示する
#setopt nonomatch
#そのときのエラーメッセージを表示させないようにする
#setopt nullglob
#グロブ機能の拡張
setopt extendedglob
#ファイル名を数値としてソート
# 1.txt 10.txt 11.txt 2.txt
#>1.txt 2.txt 10.txt 11.txt
setopt numericglobsort






#エイリアスを有効に
setopt aliases
#エイリアスの設定
alias rm='rm -i'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g GI='| grep -i'

case ${OSTYPE} in
  darwin*)
  alias java='java -Dfile.encoding=UTF-8'
  alias ls='ls -G'
  export LSCOLORS=gxfxcxdxbxegedabagacad
  ;;
  *)
  export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  ;;
esac
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'


#C-S、C-Qを有効にする
setopt flow_control
#C-Dでのログアウトを無効にする
setopt ignore_eof


#リダイレクトの上書き禁止
setopt noclobber




#各変数の重複する値を自動で削除
typeset -U path cdpath fpath manpath



#rm * をしたときに確認をしないようにする
#setopt rm_star_silent
unsetopt rm_star_silent
#rm * をしたとき10秒間入力待ち状態にする
setopt rm_star_wait



#簡易エディタzedの利用
#autoload zed
# C-XWで保存
# C-Cで終了
# zed -f 関数名 で関数を開いて編集



# 対話的なシェルでコメントを有効にする
#setopt interactive_comments
unsetopt interactive_comments
#コマンド、パスの対応をハッシュテーブルに格納して利用する
#よく分からない
setopt hash_cmds
#コマンド名のハッシュテーブル格納時にディレクトリもハッシュする
#よく分からない
#setopt hash_dirs
#コマンドに/が含まれていても通常のパス検索を行う
#よく分からない
#setopt path_dirs
#制御構文で短縮形を使用する
#よく分からない
#setopt short_loops



#コマンドを実行する
setopt exec
#関数やスクリプト実行時に、一時的に$0にその名前を代入する
#setopt function_argzero
#シェル関数終了時にすべてのオプションを復帰させる
#よく分からない
#setopt local_options
#teeコマンドなしで複数のリダイレクトを取り扱う
#setopt multios
#実行されるコマンドと引数を表示する
#setopt xtrace
unsetopt xtrace


export YSC=`date +%y`
export MSC=`date +%m`
export DSC=`date +%d`


#if [ $TERM = "screen" ];
#then
#  precmd () {
#    echo -ne "\ek$(basename $(pwd))\e\\"
#  }
#  preexec () {
#    echo -ne "\ek#${1%% *}\e\\"
#  }
#fi


show_window_title() {
    if [ "$TERM" = "screen" ]; then
      chpwd() { echo -n "\ek`basename $PWD`\e\\" }
      preexec() {
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
          fg)
              if (( $#cmd == 1 )); then
                cmd=(builtin jobs -l %+)
              else
                cmd=(builtin jobs -l $cmd[2])
              fi
              ;;
          %*)
              cmd=(builtin jobs -l $cmd[1])
              ;;
          cd)
              if (( $#cmd == 2 )); then
                cmd[1]=$cmd[2]
              fi
              ;;
          ls|clear)
              echo -n "\ek$ZSH_NAME\e\\"
              return
              ;;
          screen|pwd)
              return
              ;;
          *)
              echo -n "\ek$cmd[1]:t\e\\"
              return
              ;;
        esac
        local -A jt; jt=(${(kv)jobtexts})
        $cmd >>(read num rest
                cmd=(${(z)${(e):-\$jt$num}})
                echo -n "\ek$cmd[1]:t\e\\") 2>/dev/null
      }
    fi
}

show_window_title


#rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

