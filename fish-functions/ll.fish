function ll --description 'List contents of directory using long format'
#	ls -lh --time-style=long-iso $argv
	ls -loh -D "%F %R" $argv
end
