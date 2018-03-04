config const rows = 100, cols = 100;      // number of rows and columns in a matrix
const rowStride = 20, colStride = 20;
config const niter = 500;     // number of iterations
config const iout = 1, jout = 1;    // some row and column numbers
var delta: real;    // the greatest temperature difference from one iteration to next
config const tolerance = 0.0001: real;   // temperature difference tolerance
var count = 0: int;                // the iteration counter
config const nout = 20: int;             // the temperature at (x,y) will be printed every nout interations
writeln('Working with a matrix ', rows, 'x', cols, ' to ', niter, ' iterations or dT below ', tolerance);
var T: [0..rows+1,0..cols+1] real;      // current temperatures
var Tnew: [0..rows+1,0..cols+1] real;   // newly computed temperatures
T[1..rows,1..cols] = 25;     // set the initial temperature
delta = tolerance;
writeln('Temperature at iteration ', count, ': ', T[iout,jout]);
use Time;
var watch: Timer;
watch.start();
while (count < niter && delta >= tolerance) do {
  for i in 1..rows do
    T[i,cols+1] = i*80.0/rows;
  for j in 1..cols do
    T[rows+1,j] = j*80.0/cols;
  count += 1;      // increase the iteration counter by one
  delta = 0;
  forall (i,j) in {1..rows,1..cols} by (rowStride,colStride) with (max reduce delta) { // 5x5 decomposition into 20x20 blocks => up to 25 tasks
    for k in i..i+rowStride-1 {         // serial loop inside each subgrid over its local k-range
      for l in j..j+colStride-1 do {    // serial loop inside each subgrid over its local l-range
    	Tnew[k,l] = (T[k-1,l] + T[k+1,l] + T[k,l-1] + T[k,l+1]) / 4;
	var tmp = abs(Tnew[k,l] - T[k,l]);
	if tmp > delta then delta = tmp;
      }
    }
  }  
  T = Tnew;    // update T once all elements of Tnew are calculated
  if count%nout == 0 then writeln('Temperature at iteration ', count, ': ', T[iout,jout]);
}
watch.stop();
writeln('The simulation took ', watch.elapsed(), ' seconds');
writeln('Final temperature at the desired position after ', count, ' iterations is: ', T[iout,jout]);
writeln('The difference in temperatures between the last two iterations was: ', delta);
