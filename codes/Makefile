test: test.chpl
	chpl $^ -o $@
parallel1: parallel1.chpl
	chpl --fast $^ -o $@
parallel2: parallel2.chpl
	chpl --fast $^ -o $@
parallel3: parallel3.chpl
	chpl --fast $^ -o $@
baseSolver: baseSolver.chpl
	chpl --fast $^ -o $@
blocks: blocks.chpl
	chpl $^ -o $@
evolution: evolution.chpl
	chpl $^ -o $@
periodic: periodic.chpl
	chpl $^ -o $@
hello: hello6-taskpar-dist.chpl
	chpl $^ -o $@
atomic: atomic.chpl
	chpl $^ -o $@
locality: locality.chpl
	chpl $^ -o $@
pi: pi.chpl
	chpl $^ -o $@
clean:
	@/bin/rm -rf *~ *.o core.* output.dat
	@find . -maxdepth 1 -type f -executable -exec rm {} +
	@find . -type f -perm u=x | xargs /bin/rm -rf
