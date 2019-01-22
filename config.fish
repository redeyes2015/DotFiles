if test -f /usr/share/autojump/autojump.fish;
  source  /usr/share/autojump/autojump.fish;
end

if test "$TERM" = "xterm"
  if test -n "$COLORTERM"
    if test "$COLORTERM" = "gnome-terminal" -o "$COLORTERM" = "xfce4-terminal"
      set -x TERM "gnome-256color"
    end
  else if test -n "$VTE_VERSION"
    set -x TERM "gnome-256color"
  end
end

