use Random;
config const m = 8: int;
const nelem = 10**m: int;
var x: [1..nelem] real;
fillRandom(x);   // fill array with random numbers
var gmax = 0.0;

// here put your code to compute gmax using coforall
config const numthreads = 12;   // let's pretend we have 12 cores
const n = nelem / numthreads;    // number of elements per thread
const r = nelem - n*numthreads;    // these elements did not fit into the last thread
var lmax: [1..numthreads] real;   // local maxima for each thread

coforall threadid in 1..numthreads do {
  var start, finish: int;
  start = (threadid-1)*n + 1;
  finish = (threadid-1)*n + n;
  if threadid == numthreads then finish += r;   // add r elements to the last thread
  for i in start..finish do
    if x[i] > lmax[threadid] then lmax[threadid] = x[i];
 }

// put largest lmax into gmax
for threadid in 1..numthreads do     // a serial loop
 if lmax[threadid] > gmax then gmax = lmax[threadid];

//gmax = max reduce x;   // 'max' is one of the reduce operators

writeln('the maximum value in x is :', gmax);
