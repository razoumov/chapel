test: blocks.chpl
	chpl -o $@ $^
hello: hello6-taskpar-dist.chpl
	chpl -o $@ $^
pi: pi.chpl
	chpl -o $@ $^
clean:
	@/bin/rm -rf *~ *.o hello test *_real
#	@find . -type f -perm +111 | xargs /bin/rm -rf
