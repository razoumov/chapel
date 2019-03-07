%: %.chpl
	chpl $^ -o $@
UNAME := $(shell uname)
clean:
	@/bin/rm -rf *~ *.o core.* output.dat
ifeq ($(UNAME), Darwin)
	@find . -perm +111 -type f | xargs /bin/rm -rf
endif
ifeq ($(UNAME), Linux)
	@find . -maxdepth 1 -type f -executable -exec rm {} +
endif
