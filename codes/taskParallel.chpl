var T: [1..100,1..100] real; // define T as a 2D array
var x, y: real;

for (i,j) in T.domain { // serial iteration
  x = ((i:real)-0.5)/100.0;
  y = ((j:real)-0.5)/100.0;
  T[i,j] = exp(-((x-0.5)**2 + (y-0.5)**2)/0.01); // narrow gaussian peak
}

for idx in T.domain do
  writeln((idx,T[idx[1],idx[2]]));

forall idx in T.domain do // reasonable or "--dataParTasksPerLocale=..." number of tasks
  writeln((idx,T[idx[1],idx[2]]));

coforall (i,j) in T.domain by (20,20) { // 5x5 decomposition into 20x20 blocks => 25 tasks
  for k in i..i+19 { // serial loop inside each block
    for l in j..j+19 do {
      writeln((i,j,k,l));
    }
  }
}

const space = {1..100}, alpha = 2;
var A, B, C: [space] real;
forall (a,b,c) in zip(A,B,C) do  // reasonable or "--dataParTasksPerLocale=..." number of tasks
  a = b + alpha*c;

A = B + alpha * C; // equivalent to the previous zippered forall version

// local vs global variables, parallel reduction
var x = 1; // x is defined outside forall, so it has the same (global) value for all threads
forall i in 1..10 {
  var y:real = i; // can't assign global x inside the parallel loop, but can define a new local variable y
  writeln((x,y)); 
}

var counter1 = 0;
coforall i in 1..10 with (+ reduce counter1) { // we have 10 local (per thread) counter1=1 which we then sum up
  counter1 = 1;
}
writeln('counter1 = ', counter1); // prints 10

var counter2 = 0;
forall i in 1..10 with (+ reduce counter2) { // we have fewer threads so the final counter2 is likely smaller
  counter2 = 1;
}
writeln('counter2 = ', counter2); // prints the actual number of threads (if not larger than 10)

var total:real = 0;
forall i in 1..100 with (+ reduce total) { // we have fewer threads so the final counter2 is likely smaller
  total += i;
}
writeln('total = ', total); // prints the sum computed in parallel, result independent of the # of threads
