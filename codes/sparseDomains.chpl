config var n = 9;
const dnsDom = {1..n, 1..n};
var spsDom: sparse subdomain(dnsDom); // initially an empty subset of indices of dnsDom
var spsArr: [spsDom] real; // sparse array on top of the sparse domain

// for ij in spsDom do
//   writeln(ij);

writeln("Initially, spsDom is: ", spsDom);
writeln("Initially, spsArr is: ", spsArr);
writeln();

proc writeSpsArr() {
  for (i,j) in dnsDom {
    write(spsArr(i,j), " ");
    if (j == n) then writeln();
  }
  writeln();
}

writeln("Printing spsArr with a dense representation:");
writeSpsArr();

spsArr.IRV = 1e-3; // change the default Implicitly Replicated Value
writeln("Printing spsArr after changing its IRV:");
writeSpsArr();

spsDom += (1,n); // add corners to the sparse domain
spsDom += (n,n);
spsDom += (1,1);
spsDom += (n,1);

spsArr[1,1] = 100;

writeln("After adding corners, spsDom is:\n", spsDom);
writeln("After adding corners, spsArr is:\n", spsArr);
writeln();

for (i,j) in dnsDom {
  if spsDom.member(i,j) then
    write("* "); // (i,j) is a member in the sparse index set
  else
    write(". "); // (i,j) is not a member in the sparse index set
  if (j == n) then writeln();
}
writeln();

var sparseSum = + reduce spsArr;
var denseSum = + reduce [ij in dnsDom] spsArr(ij);

writeln("the sum of the sparse elements is: ", sparseSum);
writeln("the sum of the dense elements is: ", denseSum);
writeln();

spsDom.clear();     // empty the sparse index set
spsArr.IRV = 0.0;   // reset the Implicitly Replicated Value

for i in 1..n do
  spsDom += (i,i);   // add the main diagonal to the sparse domain

[(i,j) in spsDom] spsArr(i,j) = i + j;

writeln("Printing spsArr after resetting and adding the diagonal:");
writeSpsArr();

iter antiDiag(n) {
  for i in 1..n do
    yield (i, n-i+1);
}

spsDom = antiDiag(n);

[(i,j) in spsDom] spsArr(i,j) = i + j;

writeln("Printing spsArr after resetting and assigning the antiDiag iterator:");
writeSpsArr();
