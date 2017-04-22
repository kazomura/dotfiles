# create work directory
export work_dir=${HOME}/`date +"work/%Y/%m/%d"`
mkdir -p ${work_dir}

function peco-history-selection {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-open-repository-by-atom {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="atom ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-open-repository-by-atom
bindkey '^a' peco-open-repository-by-atom
