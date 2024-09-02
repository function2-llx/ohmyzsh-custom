# user@host, full path, date&time with timezone on two lines for easier vgrepping
# modified from the official `rkj-repos` theme

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    local ref=$(command git rev-parse --short HEAD 2> /dev/null)
    if [[ -z $ref ]]; then
      return
    fi
    local branch=$(git branch --show-current 2> /dev/null)
    # ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    # ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    if [[ -z $branch ]]; then
      echo "($(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[blue]%}) "
    else
      echo "($branch → $(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[blue]%}) "
    fi
  fi
}

function retcode() {}

function virtualenv_info {
    # copy from fino-time
    [ $CONDA_DEFAULT_ENV ] && echo "($CONDA_DEFAULT_ENV) "
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function format_datetime {
    echo $(date +'%Y-%m-%d %H:%M:%S UTC%:z %Z')
}

PROMPT=$'%{$fg_bold[blue]%}┌─[%{$fg_bold[green]%}%n%b%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg_bold[blue]%}]%{$reset_color%} %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%} %{$fg_bold[blue]%}[%b%{$fg[yellow]%}$(format_datetime)'%b$'%{$fg_bold[blue]%}]
%{$fg_bold[blue]%}└─[%{$fg_bold[magenta]%}%?$(retcode)%{$fg_bold[blue]%}] $(mygit)%{$reset_color%}$(virtualenv_info)'
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
