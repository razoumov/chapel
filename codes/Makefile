output: output.chpl dependencies.c dependencies.h
	chpl -I/usr/local/include -L/usr/local/lib output.chpl -o output
baseSolverWithOutput: baseSolverWithOutput.chpl
	chpl --fast -I/usr/local/include -L/usr/local/lib baseSolverWithOutput.chpl -o baseSolverWithOutput
%: %.chpl
	chpl $^ -o $@
# output: output.chpl libdeps.so
# 	chpl output.chpl -o output -L. -ldeps
# libdeps.so: dependencies.c
# 	gcc -O2 -Wall -fPIC -c dependencies.c
# 	gcc -shared -o libdeps.so dependencies.o
# output: output.chpl
# 	chpl $^ -o $@
# 	# chpl -I/usr/local/include -L/usr/local/lib -lnetcdf output.chpl -o output
# 	# ./output --rows=30 --cols=30 --nout=100 --niter=5000
driver: driver.o dependencies.o
	gcc -O2 driver.o dependencies.o -o driver
%.o: %.c
	gcc -O2 -c $^
UNAME := $(shell uname)
clean:
	@/bin/rm -rf *~ *.o core.* output.dat
ifeq ($(UNAME), Darwin)
	@find . -perm +111 -type f | xargs /bin/rm -rf
endif
ifeq ($(UNAME), Linux)
	@find . -maxdepth 1 -type f -executable -exec rm {} +
endif
