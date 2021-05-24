use BlockDist;
const space = {1..8, 1..8};  // 2D domain
const dom: domain(2) dmapped Block(boundingBox={1..8,1..8}) = space; // 2D domain map with some
								     // decomposition; on 2-3 locales
								     // this produces 1D decomposition;
								     // on 4 locales - 2D (2x2) decomposition
var A: [dom] string; // array of integers across domain dom
forall a in A do { // go through all 64 elements in A
  a = a.locale.id:string + '_' + here.name[0..4] + '_' + here.maxTaskPar:string + '  ';
 }
writeln(A);
