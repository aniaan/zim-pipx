[[ -d ${HOME}/.local/bin ]] && path=(${HOME}/.local/bin ${path:#${HOME}/.local/bin})

(( ${+commands[pipx]} )) && () {
  local command=${commands[pipx]}
  local compfile="$1/functions/_pipx"

  if [[ ! -e "$compfile" || "$compfile" -ot "$command" ]]; then
    # 生成补全脚本
    if (( ${+commands[register-python-argcomplete]} )); then
      register-python-argcomplete pipx >| "$compfile"
      zcompile -UR "$compfile"
      print -u2 -PR "* Detected a new version of 'pipx'. Regenerated completions."
    fi
  fi
} "${0:h}"
