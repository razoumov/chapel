// http://chapel.cray.com/docs/1.14/primers/primers/distributions.html
// d. Data parallelism: work with T as a matrix, explore mapping its domain with different methods.
// e. Advanced features: Save data of iterations to file, maybe create a customized iterator for the problem ?

config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
var T: [mesh] real; // a 2D array defined in shared memory on a single locale (mapped onto this domain)

use BlockDist;
// distributedMesh is a n^2 block-distributed domain mapped to locales
const distributedMesh: domain(2) dmapped Block(boundingBox=mesh) = mesh;
// A is a 2D string block-distributed array on top of the distributed domain mapped to locales
var A: [distributedMesh] string;
forall a in A { // go through all n^2 elements in A
  // here.id and a.locale.id refer to the same thing (the ID of the current locale)
  a = "%i".format(a.locale.id) + '-' + here.name + '-' + here.maxTaskPar + '  ';
}
// writeln(A);

// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 0-b402-12   0-b402-12   0-b402-12   0-b402-12   1-b403-12   1-b403-12   1-b403-12   1-b403-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12
// 2-b410-12   2-b410-12   2-b410-12   2-b410-12   3-b411-12   3-b411-12   3-b411-12   3-b411-12

use CyclicDist; // elements are sent to locales in a round-robin pattern
const m2: domain(2) dmapped Cyclic(startIdx=mesh.low) = mesh; // mesh.low is the first index (1,1)
var A2: [m2] string;
forall a in A2 {
  a = "%i".format(a.locale.id) + '-' + here.name + '-' + here.maxTaskPar + '  ';
}
// writeln(A2);

// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12
// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12
// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12
// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12

// These are predefined distributions: BlockDist, CyclicDist, BlockCycDist, ReplicatedDist,
// DimensionalDist2D, ReplicatedDim, BlockCycDim - for details see
// http://chapel.cray.com/docs/1.12/modules/distributions.html

// evolution.chpl
