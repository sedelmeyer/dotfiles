# Shortcuts and tricks in bash

ctrl-r	-> search my history
{}	-> magical braces
		file.{jpg,png} expands to file.jpg file.png
		{1..5} expands to 1 2 3 4 5
!!	-> expands to last run command
' '	-> commands that start with a space aren't added to history
$()	-> gives output of command
		touch file-$(date -I).md
		creates file-2020-09-04.md
SOURCE: https://hackernoon.com/10-basic-tips-on-working-fast-in-unix-or-linux-terminal-5746ae42d277

history	-> shows bash history

