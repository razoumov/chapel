all: parallel2
test: test.chpl
	chpl --fast $^ -o $@
baseSolver: baseSolver.chpl
	chpl --fast $^ -o $@
begin: begin.chpl
	chpl $^ -o $@
cobegin: cobegin.chpl
	chpl $^ -o $@
coforall: coforall.chpl
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
upload:
	doctoc 01-base.md                 # insert table of contents
	doctoc 02-task-parallelism.md     # insert table of contents
	doctoc 03-domain-parallelism.md   # insert table of contents
#	grip chapel.md --export chapel.html --title="chapel"   # generate html
	@/bin/cp -f 01-base.md 02-task-parallelism.md 03-domain-parallelism.md ~/Movies/publish
	@ls -lh ~/Movies/publish/{01-base,02-task-parallelism,03-domain-parallelism}.md
clean:
	@/bin/rm -rf *~ *.aux *.nav *.synctex* *.log *.out *.snm
	@find . -type f -perm +111 -maxdepth 1 | xargs /bin/rm -rf
