use BlockDist;

config const n = 10;
const D = {1..n, 1..n} dmapped Block({1..n, 1..n});  // distributed dense index set
var SD: sparse subdomain(D);                         // distributed sparse subset, initially empty
var A: [SD] int;                                     // distributed sparse array

const mesh = {1..n, 1..n};
var C: [mesh] real;
C = 1;

// populate the sparse index set
// SD += (1,1);
// SD += (n/2, n/4);
// SD += (3*n/4, 3*n/4);
// SD += (n, n);
for i in 1..n do {
  SD += (i,i);
  SD += (1,i);
  SD += (i,n);
 }

// assign the sparse array elements in parallel
forall a in A do
  a = here.id + 1;

// print a dense view of the array
writeln('A =');
for i in 1..n {
  for j in 1..n do
    write(A[i,j], " ");
  writeln();
}

use LinearAlgebra;

writeln(C.dot(C));

// writeln('B =');
// for i in 1..n {
//   for j in 1..n do
//     write(B[i,j], " ");
//   writeln();
// }
