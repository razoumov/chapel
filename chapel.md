# Introduction to heat equation

Slide: original 2D diffusion equation, discretized equation with forward Euler (explicit) time stepping.

Slide: assumptions, the final 2D finite-difference equation.

# Chapel base language

Slide: why another language?

Slide: useful links.

Slide: exercise with the bisection method.

# Task parallelism

locality.chpl

# Data parallelism

## Domains and single-locale data parallelism

To run single-locale Chapel on Graham:

~~~ {.bash}
mkdir someDirectory && cd someDirectory   # cd ~/chapelCourse/codes
chapelSingleLocale
salloc --time=0:30:0 --ntasks=1 --cpus-per-task=3 --mem-per-cpu=1000 --account=def-razoumov-ac
make test           # chpl test.chpl -o test
./test
~~~

Recall: ranges are 1D sets of integer indices.

~~~ {.chapel}
var range1to10: range = 1..10; // 1, 2, 3, ..., 10
var a = 1234, b = 5678;
var rangeatob: range = a..b; // using variables
var range2to10by2: range(stridable=true) = 2..10 by 2; // 2, 4, 6, 8, 10
var range1toInf = 1.. ; // unbounded range
~~~

Recall: domains are bounded multi-dimensional sets of integer indices.

~~~ {.chapel}
var domain1to10: domain(1) = {1..10};        // 1D domain from 1 to 10
var twoDimensions: domain(2) = {-2..2,0..2}; // 2D domain over a product of ranges
var thirdDim: range = 1..16;
var threeDims: domain(3) = {thirdDim, 1..10, 5..10}; // 3D domain using a range variable
for idx in twoDimensions do
  write(idx, ", ");
writeln();
for (x,y) in twoDimensions {
  write("(", x, ", ", y, ")", ", "); // these tuples can also be deconstructed
}
~~~

Let's define an n^2 domain and print out

(1) t.locale.id = the ID of the locale holding the element t of T (should be 0)
(2) here.id = the ID of the locale on which the code is running (should be 0)
(3) here.maxTaskPar = the number of cores (max parallelism with 1 task/core) (should be 3)

~~~ {.chapel}
config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
var T: [mesh] real; // a 2D array of reals defined in shared memory on a single locale (mapped onto this domain)
forall t in T { // go in parallel through all n^2 elements of T
  writeln((t.locale.id,here.id,here.maxTaskPar));
}
~~~

By the way, how do we access indices of T?

~~~ {.chapel}
forall t in T.domain {
  writeln(t);   // t is a tuple (i,j)
}
~~~

How can we define multiple arrays on the same mesh?

~~~ {.chapel}
const grid = {1..100}; // 1D domain
const alpha = 5; // some number
var A, B, C: [grid] real; // local arrays on this 1D domain
B = 2; C = 3;
forall (a,b,c) in zip(A,B,C) do // parallel loop
  a = b + alpha*c;   // simple example of data parallelism on a single locale
writeln(A);
~~~

## Distributed domains

Domains are fundamental Chapel concept for distributed-memory data parallelism. But before we jump into
this, we need to learn how to run multi-locale Chapel on Graham:

~~~ {.bash}
cd ~/chapelCourse/codes
chapelMultiLocale   # load Chapel variables defined in ~/.bashrc
salloc --time=0:30:0 --nodes=2 --cpus-per-task=3 --mem-per-cpu=1000 --account=def-razoumov-ac
make test        # chpl test.chpl -o test
srun ./test_real -nl 2   # will run on two locales with max 3 cores per locale
~~~

Let's now define an n^2 distributed (over several locales) domain distributedMesh mapped to locales in
blocks. On top of this domain we define a 2D block-distributed array A of strings mapped to locales in
exactly the same pattern as the underlying domain. Let's print out

(1) a.locale.id = the ID of the locale holding the element a of A
(2) here.name = the name of the locale on which the code is running
(3) here.maxTaskPar = the number of cores on the locale on which the code is running

We'll package output into each element of A as a string:
a = "%i".format(int) + string + int
is a shortcut for
a = "%i".format(int) + string + "%i".format(int)

~~~ {.chapel}
use BlockDist; // use standard block distribution module to partition the domain into blocks
config const n = 8;
const mesh: domain(2) = {1..n, 1..n};
const distributedMesh: domain(2) dmapped Block(boundingBox=mesh) = mesh;
var A: [distributedMesh] string; // block-distributed array mapped to locales
forall a in A { // go in parallel through all n^2 elements in A
  // assign each array element on the locale that stores that index/element
  a = "%i".format(a.locale.id) + '-' + here.name + '-' + here.maxTaskPar + '  ';
}
writeln(A);
~~~~

Let's try to run this on 1, 2, 4 locales. Here is an example on 4 locales with 1 core/local:

0-gra796-1   0-gra796-1   0-gra796-1   0-gra796-1   1-gra797-1   1-gra797-1   1-gra797-1   1-gra797-1  
0-gra796-1   0-gra796-1   0-gra796-1   0-gra796-1   1-gra797-1   1-gra797-1   1-gra797-1   1-gra797-1  
0-gra796-1   0-gra796-1   0-gra796-1   0-gra796-1   1-gra797-1   1-gra797-1   1-gra797-1   1-gra797-1  
0-gra796-1   0-gra796-1   0-gra796-1   0-gra796-1   1-gra797-1   1-gra797-1   1-gra797-1   1-gra797-1  
2-gra798-1   2-gra798-1   2-gra798-1   2-gra798-1   3-gra799-1   3-gra799-1   3-gra799-1   3-gra799-1  
2-gra798-1   2-gra798-1   2-gra798-1   2-gra798-1   3-gra799-1   3-gra799-1   3-gra799-1   3-gra799-1  
2-gra798-1   2-gra798-1   2-gra798-1   2-gra798-1   3-gra799-1   3-gra799-1   3-gra799-1   3-gra799-1  
2-gra798-1   2-gra798-1   2-gra798-1   2-gra798-1   3-gra799-1   3-gra799-1   3-gra799-1   3-gra799-1  

Now print the range of indices for each sub-domain by adding the following to our code:

~~~ {.chapel}
for loc in Locales {
  on loc {
    writeln(A.localSubdomain());
  }
}
~~~

On 4 locales we should get:

{1..4, 1..4}  
{1..4, 5..8}  
{5..8, 1..4}  
{5..8, 5..8}  

Let's count the number of threads by adding the following to our code:

~~~ {.chapel}
var counter = 0;
forall a in A with (+ reduce counter) { // go in parallel through all n^2 elements
  counter = 1;
}
writeln("actual number of threads = ", counter);
~~~

Does the number make sense? If running on a large number of cores, the result will depend heavily depends
on n (the size of the domain): for large n=30 will maximize the number of threads on each locale, for
small n=5 will run a few threads per locale.

So far we looked at block distribution. Let's take a look at another standard module to partition the
domain among locales, called CyclicDist. For each element of the array we will print out again

(1) a.locale.id = the ID of the locale holding the element a of A
(2) here.name = the name of the locale on which the code is running
(3) here.maxTaskPar = the number of cores on the locale on which the code is running

~~~ {.chapel}
use CyclicDist; // elements are sent to locales in a round-robin pattern
config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
const m2: domain(2) dmapped Cyclic(startIdx=mesh.low) = mesh; // mesh.low is the first index (1,1)
var A2: [m2] string;
forall a in A2 {
  a = "%i".format(a.locale.id) + '-' + here.name + '-' + here.maxTaskPar + '  ';
}
writeln(A2);
~~~

0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1  
2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1  
0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1  
2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1  
0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1  
2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1  
0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1   0-gra796-1   1-gra797-1  
2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1   2-gra798-1   3-gra799-1  

Again let's print the range of indices for each sub-domain by adding the following to our code:

~~~ {.chapel}
for loc in Locales {
  on loc {
    writeln(A2.localSubdomain());
  }
}
~~~

{1..7 by 2, 1..7 by 2}  
{1..7 by 2, 2..8 by 2}  
{2..8 by 2, 1..7 by 2}  
{2..8 by 2, 2..8 by 2}  

There are quite a few predefined distributions: BlockDist, CyclicDist, BlockCycDist, ReplicatedDist,
DimensionalDist2D, ReplicatedDim, BlockCycDim - for details see
http://chapel.cray.com/docs/1.12/modules/distributions.html

## Diffusion solver on distributed domains

abc
use BlockDist;

config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale

// largerMesh is a (n+2)^2 block-distributed mesh mapped to locales, with one-cell-wide "ghost zones" on "end locales"
const largerMesh: domain(2) dmapped Block(boundingBox=mesh) = {0..n+1, 0..n+1};
var TT: [largerMesh] real;
forall (i,j) in mesh {
  var x = ((i:real)-0.5)/(n:real); // x, y are local to each task
  var y = ((j:real)-0.5)/(n:real);
  TT[i,j] = exp(-((x-0.5)**2 + (y-0.5)**2) / 0.01); // narrow gaussian peak
}

// writeln(TT);

// 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
// 0.0 2.36954e-17 2.79367e-13 1.44716e-10 3.29371e-09 3.29371e-09 1.44716e-10 2.79367e-13 2.36954e-17 0.0
// 0.0 2.79367e-13 3.29371e-09 1.70619e-06 3.88326e-05 3.88326e-05 1.70619e-06 3.29371e-09 2.79367e-13 0.0
// 0.0 1.44716e-10 1.70619e-06 0.000883826 0.0201158 0.0201158 0.000883826 1.70619e-06 1.44716e-10 0.0
// 0.0 3.29371e-09 3.88326e-05 0.0201158 0.457833 0.457833 0.0201158 3.88326e-05 3.29371e-09 0.0
// 0.0 3.29371e-09 3.88326e-05 0.0201158 0.457833 0.457833 0.0201158 3.88326e-05 3.29371e-09 0.0
// 0.0 1.44716e-10 1.70619e-06 0.000883826 0.0201158 0.0201158 0.000883826 1.70619e-06 1.44716e-10 0.0
// 0.0 2.79367e-13 3.29371e-09 1.70619e-06 3.88326e-05 3.88326e-05 1.70619e-06 3.29371e-09 2.79367e-13 0.0
// 0.0 2.36954e-17 2.79367e-13 1.44716e-10 3.29371e-09 3.29371e-09 1.44716e-10 2.79367e-13 2.36954e-17 0.0
// 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0

// var nodeID: [largerMesh] string;
// forall m in nodeID do
//   m = "%i".format(here.id);
// writeln(nodeID);

// 0 0 0 0 0 1 1 1 1 1 - the outer perimeter is "ghost zones"
// 0 0 0 0 0 1 1 1 1 1
// 0 0 0 0 0 1 1 1 1 1
// 0 0 0 0 0 1 1 1 1 1
// 0 0 0 0 0 1 1 1 1 1
// 2 2 2 2 2 3 3 3 3 3
// 2 2 2 2 2 3 3 3 3 3
// 2 2 2 2 2 3 3 3 3 3
// 2 2 2 2 2 3 3 3 3 3
// 2 2 2 2 2 3 3 3 3 3

var TTnew: [mesh] real;
for step in 1..5 {
  forall (i,j) in mesh do
    TTnew[i,j] = (TT[i-1,j] + TT[i+1,j] + TT[i,j-1] + TT[i,j+1]) / 4;
  TT[mesh] = TTnew[mesh]; // uses parallel forall underneath
  writeln((step, TT[n/2,n/2], TT[2,2]));
  // we implemented an open boundary: TT in "ghost zones" is always 0; let's calculate total TT
  //  var total = + reduce TT; // this does not work for some reason ...
  var total: real = 0;
  forall (i,j) in mesh with (+ reduce total) do
    total += TT[i,j];
  writeln("total = ", total);
}


















Domain types http://chapel.cray.com/tutorials/ACCU2017/03-DataPar.pdf

http://chapel.cray.com/docs/1.14/primers/primers/distributions.html
http://chapel.cray.com/tutorials/ACCU2017/03-DataPar.pdf
builtin Locales variable
- for loc in Locales {} followed by on loc {}
- do something on Locales[1]
become very proficient with regular domains

periodic.chpl
- exercise: modify evolution.chpl to put in periodic BCs
- check energy conservation
- write out each timestep to an ASCII file


### Advanced language features
