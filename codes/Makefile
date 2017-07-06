test: taskParallel.chpl
# learnChapelInYMinutes.chpl hello4-datapar-dist.chpl hello6-taskpar-dist.chpl
# hello3-datapar.chpl hello5-taskpar.chpl domainMaps.chpl
	chpl -o $@ $^
pi: pi.chpl
	chpl -o $@ $^
clean:
	@/bin/rm -rf *~ *.o
	@find . -type f -perm +111 | xargs /bin/rm -rf
