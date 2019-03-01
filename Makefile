%: %.chpl
	chpl $^ -o $@
upload:
	doctoc 01-base.md                 # insert table of contents
	doctoc 02-task-parallelism.md     # insert table of contents
	doctoc 03-domain-parallelism.md   # insert table of contents
	doctoc 08-seminarVersion.md
	@/bin/cp -f {01-base,02-task-parallelism,03-domain-parallelism,08-seminarVersion}.md ~/Movies/publish
	@ls -lh ~/Movies/publish/{01-base,02-task-parallelism,03-domain-parallelism,08-seminarVersion}.md
n1 = 01-base
n2 = 02-task-parallelism
n3 = 03-domain-parallelism
html:
	grip $(n1).md --export $(n1).html --title="$(n1)"
	grip $(n2).md --export $(n2).html --title="$(n2)"
	grip $(n3).md --export $(n3).html --title="$(n3)"
clean:
	echo $(uname)
	@/bin/rm -rf *~ *.aux *.nav *.synctex* *.log *.out *.snm
