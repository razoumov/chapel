test: evolution.chpl
	chpl -o $@ $^
pi: pi.chpl
	chpl -o $@ $^
clean:
	@/bin/rm -rf *~ *.o
	@find . -type f -perm +111 | xargs /bin/rm -rf
