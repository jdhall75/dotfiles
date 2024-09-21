# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jhall/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/jhall/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/jhall/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/jhall/.fzf/shell/key-bindings.bash"
