use BlockDist;

config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale

// largerMesh is a (n+2)^2 block-distributed mesh mapped to locales, with one-cell-wide "ghost zones" on "end locales"
const largerMesh: domain(2) dmapped Block(boundingBox=mesh) = {0..n+1, 0..n+1};
var T: [largerMesh] real;
forall (i,j) in T.domain[1..n,1..n] {
  var x = ((i:real)-0.5)/(n:real); // x, y are local to each task
  var y = ((j:real)-0.5)/(n:real);
  T[i,j] = exp(-((x-0.5)**2 + (y-0.5)**2) / 0.01); // narrow gaussian peak
}

// writeln(T);

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

var Tnew: [mesh] real;
for step in 1..5 {
  forall (i,j) in T.domain[1..n,1..n] do
    Tnew[i,j] = (T[i-1,j] + T[i+1,j] + T[i,j-1] + T[i,j+1]) / 4;
  T[mesh] = Tnew[mesh]; // uses parallel forall underneath
  writeln((step, T[n/2,n/2], T[2,2]));
  // we implemented an open boundary: T in "ghost zones" is always 0; let's calculate total T
  //  var total = + reduce T; // this does not work for some reason ...
  var total: real = 0;
  forall (i,j) in mesh with (+ reduce total) do
    total += T[i,j];
  writeln("total = ", total);
}
