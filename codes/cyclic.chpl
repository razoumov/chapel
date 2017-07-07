use CyclicDist; // elements are sent to locales in a round-robin pattern
config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
const m2: domain(2) dmapped Cyclic(startIdx=mesh.low) = mesh; // mesh.low is the first index (1,1)
var A2: [m2] string;
forall a in A2 {
  a = "%i".format(a.locale.id) + '-' + here.name + '-' + here.maxTaskPar + '  ';
}
writeln(A2);

// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12
// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12
// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12
// 0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12   0-b402-12   1-b403-12
// 2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12   2-b410-12   3-b411-12

for loc in Locales {
  on loc {
    writeln(A2.localSubdomain());
  }
}

// These are predefined distributions: BlockDist, CyclicDist, BlockCycDist, ReplicatedDist,
// DimensionalDist2D, ReplicatedDim, BlockCycDim - for details see
// http://chapel.cray.com/docs/1.12/modules/distributions.html
