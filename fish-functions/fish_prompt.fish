# Defined in /tmp/fish.pKuPEI/fish_prompt.fish @ line 2
function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	# PWD
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal

	printf '%s ' (__fish_git_prompt)

	set -l job_id (builtin jobs $argv | command grep -v autojump | command awk -v FS=\t '
		/[0-9]+\t/{
		    aJobs[++nJobs] = $1
		}
		END {
		    for (i = 1; i <= nJobs; i++) {
			print(aJobs[i])
		    }

		    exit nJobs == 0
		}
	    ')
	if test "$job_id"
		echo -sn "$color_error(%)$color_normal"
	end

	if not test $last_status -eq 0
	set_color $fish_color_error
	end

	echo -n '$ '

	set_color normal
end
