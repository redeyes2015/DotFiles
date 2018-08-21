# source shared git completions for __fish_git_needs_command and __fish_git_using_command
source $__fish_datadir/completions/git.fish

### dsf is an alias that wraps diff -- https://github.com/so-fancy/diff-so-fancy
###  cloned from 'diff' section in /usr/local/Cellar/fish/2.6.0/share/fish/completions/git.fish
complete -c git -n '__fish_git_needs_command' -a dsf -d 'Show changes between commits, commit and working tree, etc'
complete -c git -n '__fish_git_using_command dsf' -a '(__fish_git_ranges)' -d 'Branch'
complete -c git -n '__fish_git_using_command dsf' -l cached -d 'Show diff of changes in the index'
complete -c git -n '__fish_git_using_command dsf' -l no-index -d 'Compare two paths on the filesystem'
# TODO options
