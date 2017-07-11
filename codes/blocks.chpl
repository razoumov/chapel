// this is what we saw in shared-memory parallelism

config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
var T: [mesh] real; // a 2D array defined in shared memory on a single locale (mapped onto this domain)

// let's now look at distributed-memory parallelism

use BlockDist;
// distributedMesh is a n^2 block-distributed domain mapped to locales
const distributedMesh: domain(2) dmapped Block(boundingBox=mesh) = mesh;
// A is a 2D string block-distributed array on top of the distributed domain mapped to locales in exactly
// the same pattern as the underlying domain
var A: [distributedMesh] string;
forall a in A { // go in parallel through all n^2 elements in A
  // here.id and a.locale.id refer to the same thing (the ID of the current locale);
  // assign each array element on the locale that stores that index/element
  a = "%i".format(a.locale.id) + '-' + here.name + '-' + here.maxTaskPar + '  ';
}
writeln(A);

// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12

// for loc in Locales {
//   on loc {
//     writeln(A.localSubdomain());
//   }
// }

// var counter = 0;
// forall a in A with (+ reduce counter) {
//   counter = 1;
//   writeln(a);
// }
// writeln("actual number of threads = ", counter); // heavily depends on n; for large n=30 will maximize
// 						 // the number of threads on each locale: try running
// 						 // with and without --n=30
