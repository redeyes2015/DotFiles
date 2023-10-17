if status is-interactive
    if test "$TERM" = "xterm"
      if test -n "$COLORTERM"
        if test "$COLORTERM" = "gnome-terminal" -o "$COLORTERM" = "xfce4-terminal"
          set -x TERM "gnome-256color"
        end
      else if test -n "$VTE_VERSION"
        set -x TERM "gnome-256color"
      end
    end

    set -gx HOMEBREW_PREFIX "/opt/homebrew";
    set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
    set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
    set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
    set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
    set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

    if test -f /usr/share/autojump/autojump.fish;
      source  /usr/share/autojump/autojump.fish;
    else if test -f $HOMEBREW_PREFIX/share/autojump/autojump.fish;
      source  $HOMEBREW_PREFIX/share/autojump/autojump.fish;
    end

    abbr -a -- v vim
    abbr -a -- vi vim
    abbr -a -- k kubectl
    abbr -a -- m make
    abbr -a -- g git
    abbr -a -- nr 'npm run'
    abbr -a -- tmux 'tmux -2'
    abbr -a -- gst 'git status'
    abbr -a -- gap 'git add -p'
    abbr -a -- gcfix git\ ci\ --fixup\ \(git\ log\ --oneline\ -n\ 100\ \|\ fzf\ --height\ 10\ \|\ awk\ \'\{print\ \$1\}\'\)
    abbr -a -- gco 'git checkout'
    abbr -a -- gcp 'git cherry-pick'
    abbr -a -- gd 'git dsf'
    abbr -a -- gdsg 'git dsf --staged'
    abbr -a -- gdst 'git diff --stat'
    abbr -a -- ghpco 'gh pr checkout'
    abbr -a -- ggp 'git grep'
    abbr -a -- gci 'git commit -v'
    abbr -a -- gcia 'git ci --amend'
    abbr -a -- glg 'git lg'
    abbr -a -- gf 'git fetch'
    abbr -a -- gp 'git push'
    abbr -a -- ga 'git add'
    abbr -a -- gau 'git add -u'
    abbr -a -- gpof 'git push origin --force-with-lease HEAD:'
    abbr -a -- gpoc 'git push origin --force-with-lease (git branch --show-current)'
    abbr -a -- grb 'git rebase'
    abbr -a -- grbi 'git rebase -i'
    abbr -a -- grba 'git rebase --abort'
    abbr -a -- grbc 'git rebase --continue'
    abbr -a -- vggp 'vim -q (git grep -n KEYWORD | psub)'
    abbr -a -- gmt 'git mergetool'
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish

# For the system Java wrappers to find this JDK, symlink it with
#   sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
# 
# openjdk is keg-only, which means it was not symlinked into /opt/homebrew,
# because macOS provides similar software and installing this software in
# parallel can cause all kinds of trouble.
# 
# If you need to have openjdk first in your PATH, run:
#   fish_add_path /opt/homebrew/opt/openjdk/bin
# 
# For compilers to find openjdk you may need to set:
#   set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"

