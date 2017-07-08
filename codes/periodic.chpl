use BlockDist;

config const n = 8;
const mesh: domain(2) = {1..n, 1..n};  // a 2D domain defined in shared memory on a single locale
// largerMesh is a (n+2)^2 block-distributed mesh mapped to locales, with one-cell-wide "ghost zones" on "end locales"
const largerMesh: domain(2) dmapped Block(boundingBox=mesh) = {0..n+1, 0..n+1};
var TT: [largerMesh] real;
forall (i,j) in mesh {
  var x = ((i:real)-0.5)/(n:real); // x, y are local to each task
  var y = ((j:real)-0.5)/(n:real);
  TT[i,j] = exp(-((x-0.5)**2 + (y-0.5)**2) / 0.01); // narrow gaussian peak
}

var TTnew: [mesh] real;
for step in 1..5 {
  TT[0,1..n] = TT[n,1..n]; // periodic boundaries on all four sides; these will run via parallel forall
  TT[n+1,1..n] = TT[1,1..n];
  TT[1..n,0] = TT[1..n,n];
  TT[1..n,n+1] = TT[1..n,1];
  forall (i,j) in mesh do
    TTnew[i,j] = (TT[i-1,j] + TT[i+1,j] + TT[i,j-1] + TT[i,j+1]) / 4;
  TT[mesh] = TTnew[mesh]; // uses parallel forall underneath
  writeln((step, TT[n/2,n/2], TT[2,2]));
  var total: real = 0;
  forall (i,j) in mesh with (+ reduce total) do
    total += TT[i,j];
  writeln("total = ", total); // note that now total energy is conserved
}

// write the final step to disk in ASCII
var myFile = open("sample.raw", iomode.cw); //iokind.dynamic, new iostyle(binary=1)); // binary not undertood in PV
var myWritingChannel = myFile.writer(); // create a writing channel starting at file offset 0
myWritingChannel.write(TT);
myWritingChannel.close(); // close the channel
