# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

[ -f $HOME/.env ] && export $(envsubst < $HOME/.env)
export EDITOR='nvim'
export VISUAL="nvim"
export HOMEBREW_BUNDLE_NO_LOCK='1'
export MAZ_CLI_BROWSER='w3m'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--bind ctrl-h:preview-down,ctrl-l:preview-up --preview '(bat --style=numbers --color=always --line-range :500 {} || cat {} || tree -C {}) 2> /dev/null | head -200'"

# From `delta` docs to prevent long lines from being truncated, also requires `width=250` or similar
# in .gitconfig
# export LESS=-RS

export BROWSER='xdg-open'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh/plugins/history.zsh ] && source ~/.zsh/plugins/history.zsh
[ -f ~/.zsh/plugins/titles.zsh ] && source ~/.zsh/plugins/titles.zsh

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

autoload -Uz compinit
compinit

if [ "$(uname)" = "Darwin" ]; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
else
  [ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh
fi

if [ "$(uname)" = "Darwin" ]; then
  export MAZ_TASK_SPOOLER_COMMAND='ts'
else
  export MAZ_TASK_SPOOLER_COMMAND='tsp'
fi

# Autostart tmux
# [[ -z "$TMUX" ]] && exec tmux -2

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias l='ls -alhGF'
mkdircd() { mkdir -p -v $1; cd $1 ;}    # create folder then cd into it
neovim-update() {

   cd ~/execs/bin && rm -rf nvim &&
     curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o "nvim" &&
     chmod u+x nvim &&
     cd -
}

pfx() {
    peerflix -p 55055 -f ~/Downloads/peerflix "$1"
}

ghPrMerge() {
  gh run watch "$1" && gh pr merge "$2" -sd
}

remap-super() {
  xmodmap -e "remove mod4 = Super_R" &&
    xmodmap -e "add control = Super_R"
}

# Shortcut to get the disk size of a directory and contents
sizeof() {
  du -ch "$1"
}

w3m-img() {
    $HOME/w3m/w3m -sixel -o display_image=1 $1
}

readAndCopy() {
  readable $1 -p title,text-content | xclip -selection clipboard
}

fzf-surfraw() { surfraw "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sort -n | fzf)" }
fzf-kill() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; zle -N fzf_killps;

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show %') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcoc - checkout git commit
fcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
        commit=$(echo "$commits" | fzf --tac +s +m -e) &&
        git checkout $(echo "$commit" | sed "s/ .*//")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
      --header "Press CTRL-D to show diff, CTRL-B - to check out the stash as a branch " \
      --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fag() {
    [ $# -eq 0 ] && return
    local out cols x1 x2
    if out=$(ag --nogroup --color "$@" | fzf --ansi); then

        x1=`echo $out | awk -F":" '{print $1}'`
        x2=`echo $out | awk -F":" '{print $2}'`
        vim ${x1} +"normal! ${x2}zz"

    fi
}

alias nv='nvim'
alias zsh-reload='source ~/.zshrc'

export GOPATH=~/gosrc
path+=$HOME/scripts/bin
path+=$GOPATH/bin
path+=$HOME/execs/neovim/bin
path+=$HOME/execs/bin
path+=$HOME/.gem/ruby/2.6.0/bin
path+=/usr/local/opt/node@12/bin
path+=$HOME/.cargo/bin

alias download-video='yt-dlp -S "height:1080"'
function downloadAudio() {
  yt-dlp -x --audio-format mp3 --audio-quality 1 -o "%(title)s.%(ext)s" $1
}

function downloadAudioPlaylist() {
  yt-dlp -x --audio-format mp3 --audio-quality 1 -o "%(playlist_index)s %(title)s.%(ext)s" $1
}

alias music-kill='TS_SOCKET=/tmp/yt-music $MAZ_TASK_SPOOLER_COMMAND -k'
alias music-Kill='music-kill && TS_SOCKET=/tmp/yt-music $MAZ_TASK_SPOOLER_COMMAND -K'
alias music-watch='viddy TS_SOCKET=/tmp/yt-music $MAZ_TASK_SPOOLER_COMMAND'

# filters all the audio to compress the dynamic range (i.e. make the loud stuff quieter and the quiet stuff louder)
alias mpv-drc='mpv --af="acompressor=ratio=4,loudnorm"'
alias mpv-plain='/usr/bin/mpv --af=""'

# focuses the audio on the center (where most of the dialog comes from) and reduces more of the background noise. Great for late night movies when you have sleeping kids or thin walls
alias mpv-nightmode='mpv --af="pan=stereo|FL=FC+0.30*FL+0.30*FLC+0.30*BL+0.30*SL+0.60*LFE|FR=FC+0.30*FR+0.30*FRC+0.30*BR+0.30*SR+0.60*LFE"'

# is a combination of the two.
alias mpv-nightmode-drc='mpv --af="pan=stereo|FL=FC+0.30*FL+0.30*FLC+0.30*BL+0.30*SL+0.60*LFE|FR=FC+0.30*FR+0.30*FRC+0.30*BR+0.30*SR+0.60*LFE,loudnorm"'

alias getYouAudio='youtube-dl -x --audio-format mp3 --prefer-ffmpeg '

# GIT aliases
alias gitFetchPrune="git fetch --all --prune"
alias ga='git add'
alias gaa='git add --all'
alias gst='git status'
alias gcmsg='git commit -m'

eval $(thefuck --alias)


if [ -z "$MAZ_DISABLE_EXTENSION" ]; then
  [ -f ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
