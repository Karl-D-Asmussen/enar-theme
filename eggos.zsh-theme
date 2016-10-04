# local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
# 
# if [[ $UID -eq 0 ]]; then
#     local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
# else
#     local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
# fi
# 
# local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
# local rvm_ruby=''
# if which rvm-prompt &> /dev/null; then
#   rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
# else
#   if which rbenv &> /dev/null; then
#     rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
#   fi
# fi
# local git_branch='$(git_prompt_info)%{$reset_color%}'
# ZSH_THEME_GIT_PROMPT_PREFIX='‹'
# ZSH_THEME_GIT_PROMPT_SUFFIX='›'
#
# ┌┰─karl@hq3──┤ /home/karl/Sources/zsh-theme ├──┤ 2016-10-04 15:35:36 ├───
# └┸──608───$─▶

git_prompt=''

function precmd() {
   
}

PS1=$(
  echo %n@%m %~ %{$git_prompt}
  echo %! %\#  \> 
)
PS2=$(
  echo %! %_ \> 
)

RPS1=$(
  echo %T %D
)
RPS2=$(
  echo
)
