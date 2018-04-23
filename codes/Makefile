test: test.chpl
	chpl -o $@ $^
blocks: blocks.chpl
	chpl -o $@ $^
evolution: evolution.chpl
	chpl -o $@ $^
periodic: periodic.chpl
	chpl -o $@ $^
hello: hello6-taskpar-dist.chpl
	chpl -o $@ $^
locality: locality.chpl
	chpl -o $@ $^
probeLocales: probeLocales.chpl
	chpl -o $@ $^
pi: pi.chpl
	chpl -o $@ $^
clean:
	@/bin/rm -rf *~ *.o core.*
	@find . -maxdepth 1 -type f -executable -exec rm {} +
	@find . -type f -perm u=x | xargs /bin/rm -rf
