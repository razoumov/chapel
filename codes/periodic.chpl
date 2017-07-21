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

var Tnew: [mesh] real;
for step in 1..5 {
  T[0,1..n] = T[n,1..n]; // periodic boundaries on all four sides; these will run via parallel forall
  T[n+1,1..n] = T[1,1..n];
  T[1..n,0] = T[1..n,n];
  T[1..n,n+1] = T[1..n,1];
  forall (i,j) in T.domain[1..n,1..n] do
    Tnew[i,j] = (T[i-1,j] + T[i+1,j] + T[i,j-1] + T[i,j+1]) / 4;
  T[mesh] = Tnew[mesh]; // uses parallel forall underneath
  writeln((step, T[n/2,n/2], T[2,2]));
  var total: real = 0;
  forall (i,j) in mesh with (+ reduce total) do
    total += T[i,j];
  writeln("total = ", total); // note that now total energy is conserved
}

// write the final step to disk in ASCII
var myFile = open("output.dat", iomode.cw); //iokind.dynamic, new iostyle(binary=1)); // binary not undertood in PV
var myWritingChannel = myFile.writer(); // create a writing channel starting at file offset 0
myWritingChannel.write(T);
myWritingChannel.close(); // close the channel
