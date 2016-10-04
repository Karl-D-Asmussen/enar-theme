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

function test-git {
  git rev-parse --is-inside-work-tree &>/dev/null
}

function truecolor-fg {
  print -n -- "\E[38;2;${1};${2};${3}m"
}
function truecolor-bg {
  print -n -- "\E[48;2;${1};${2};${3}m"
}

function cursor-block {
  print -n -- "\E]50;CursorShape=0\C-G"
}

function cursor-line {
  print -n -- "\E]50;CursorShape=1\C-G"
}

function cursor-underline {
  print -n -- "\E]50;CursorShape=2\C-G"
}

function ansi-blinking {
	print -n -- "\E[5m"
}

function ansi-italics {
	print -n -- "\E[3m"
}

function zle-line-init zle-keymap-select zle-line-finish {
  case "$KEYMAP" in
    (vicmd) cursor-block ;;
    (|main|viins) cursor-line ;;
  esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

function set-prompt {

  local nl='
'

  local red="%{$(truecolor-fg 255 0 0)%}"
  local ltred="%{$(truecolor-fg 255 100 100)%}"
  local green="%{$(truecolor-fg 0 255 0)%}"
  local blue="%{$(truecolor-fg 0 0 255)%}"
  local grey="%{$(truecolor-fg 100 100 100)%}"
  local ltblue="%{$(truecolor-fg 100 100 255)%}"
  local yellow="%{$(truecolor-fg 255 255 0)%}"
  local end="%{$reset_color%}"
  local bold="%{$terminfo[bold]%}"
  local blink="%{$(ansi-blinking)%}"
  local italic="%{$(ansi-italics)%}"

  local time_fmt="[%D %*]"
  local followup_type="→%_←"

  local prompt_header="  $ltred%n@%m$end  $ltblue%~$end" 

  local main_prompt='%! →→→ '
  local followup_prompt='%! ↘↘↘ '

  local git_branch=''
  local git_number=''
	local git_prompt=''
  if test-git; then
		git_number="$(git ls-files --modified --deleted --others | wc -l)"
    git_branch="$(git rev-parse --abbrev-ref HEAD)"
		if [[ $git_number == 0 ]]; then
			git_prompt="  $grey* $git_branch$end"
		else
			git_prompt="  $yellow±$git_number $git_branch$end"
		fi
  fi

	case "$1" in
		(left)
			PS1="$nl$prompt_header$git_prompt$nl$main_prompt"
			PS2="$followup_prompt"
		;;
		(right)
			RPS1="$time_fmt"
			RPS2="$followup_type"
		;;
		(*) ;;
	esac

}

function precmd {
  set-prompt left
  set-prompt right
}

