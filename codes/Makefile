%: %.chpl
	chpl --fast $^ -o $@
clean:
	@/bin/rm -rf *~ *.o core.* output.dat
	@find . -maxdepth 1 -type f -executable -exec rm {} +
	@find . -type f -perm u=x | xargs /bin/rm -rf
