all: test
test: test.chpl
	chpl $^ -o $@
baseSolver: baseSolver.chpl
	chpl --fast $^ -o $@
begin: begin.chpl
	chpl $^ -o $@
cobegin: cobegin.chpl
	chpl $^ -o $@
coforall: coforall.chpl
	chpl $^ -o $@
forall: forall.chpl
	chpl $^ -o $@
exercise1: exercise1.chpl
	chpl $^ -o $@
exercise2: exercise2.chpl
	chpl $^ -o $@
sync1: sync1.chpl
	chpl $^ -o $@
sync2: sync2.chpl
	chpl $^ -o $@
atomic: atomic.chpl
	chpl $^ -o $@
parallel1: parallel1.chpl
	chpl --fast $^ -o $@
parallel2: parallel2.chpl
	chpl --fast $^ -o $@
parallel3: parallel3.chpl
	chpl --fast $^ -o $@
upload:
	doctoc 01-base.md                 # insert table of contents
	doctoc 02-task-parallelism.md     # insert table of contents
	doctoc 03-domain-parallelism.md   # insert table of contents
	@/bin/cp -f 01-base.md 02-task-parallelism.md 03-domain-parallelism.md ~/Movies/publish
	@ls -lh ~/Movies/publish/{01-base,02-task-parallelism,03-domain-parallelism}.md
n1 = 01-base
n2 = 02-task-parallelism
n3 = 03-domain-parallelism
html:
	grip $(n1).md --export $(n1).html --title="$(n1)"
	grip $(n2).md --export $(n2).html --title="$(n2)"
	grip $(n3).md --export $(n3).html --title="$(n3)"
clean:
	@/bin/rm -rf *~ *.aux *.nav *.synctex* *.log *.out *.snm
	@find . -type f -perm +111 -maxdepth 1 | xargs /bin/rm -rf
