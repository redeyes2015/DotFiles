# Defined in /tmp/fish.toAsTB/ll.fish @ line 2
function ll --description 'List contents of directory using long format'
	ls -lh --time-style=long-iso $argv
end
