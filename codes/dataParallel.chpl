// d. Data parallelism: work with T as a matrix, explore mapping its domain with different methods.
// e. Advanced features: Save data of iterations to file, maybe create a customized iterator for the problem ?

// forall a in A do { // go through all 64 elements in A
//   a = "%i".format(a.locale.id) + '_' + here.name + '_' + here.maxTaskPar;
//  }
// writeln(A);

config const n = 10;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
var T: [mesh] real; // a 2D array defined in shared memory on a single locale

use BlockDist;
// largerMesh is a (n+2)^2 distributed mesh mapped to locales, with one-cell-wide "ghost zones" on "end locales"
const largerMesh: domain(2) = {0..n+1, 0..n+1} dmapped Block(boundingBox={1..n,1..n});
// smallerMesh is n^2, similarly mapped to locales, but without "ghost zones"
const smallerMesh = largerMesh[1..n,1..n];
// message is a 2D string array on top of our mesh mapped to locales
var message: [smallerMesh] string;
forall a in message {
  a = "%i".format(a.locale.id);
}
writeln(message);



// 2D domain map with some decomposition; on 2-3 locales this produces 1D decomposition; on 4 locales -
// 2D (2x2) decomposition







// var T: [1..100,1..100] real; // define 
// var x, y: real;

// for (i,j) in T.domain { // serial iteration
//   x = ((i:real)-0.5)/100.0;
//   y = ((j:real)-0.5)/100.0;
//   T[i,j] = exp(-((x-0.5)**2 + (y-0.5)**2)/0.01); // narrow gaussian peak
// }
