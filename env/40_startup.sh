
#############################################################################
# Kubectl
#############################################################################

source <(kubectl completion zsh)
alias k=kubectl
alias kn=kubens
alias kc=kubectx
compdef kubectl k
compdef kubens kn
compdef kubectx kc
complete -F kubectl k
complete -F kubens kn
complete -F kubectx kc


#############################################################################
# Stern
#############################################################################
source <(stern --completion=zsh)


#############################################################################
# GRC
#############################################################################
[[ -s "`brew --prefix`/etc/grc.zsh" ]] && source `brew --prefix`/etc/grc.zsh


#############################################################################
# Starship
#############################################################################
eval "$(starship init zsh)"


#############################################################################
# ZSH Syntax Highlighting
#############################################################################
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


#############################################################################
# GitHub
#############################################################################
eval "$(gh completion -s zsh)"


#############################################################################
# iTerm Shell Integration
#############################################################################
test -e "${HOME}/.iterm2_shell_integration.`basename $SHELL`" && source "${HOME}/.iterm2_shell_integration.`basename $SHELL`"
