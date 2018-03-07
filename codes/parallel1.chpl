use Time;
config const rows = 100, cols = 100;   // number of rows and columns in our matrix
config const niter = 500;   // max number of iterations
config const iout = 1, jout = cols;   // some row and column numbers

var delta: real;    // the greatest temperature difference between Tnew and T
var tmp: real;   // for temporary results

config const tolerance = 1e-4: real;   // temperature difference tolerance
var count = 0: int;    // the iteration counter
config const nout = 20: int;    // T[iout,jout] will be printed every nout steps

writeln('Working with a matrix ', rows, 'x', cols, ' to ', niter, ' iterations or dT below ', tolerance);

var T: [0..rows+1,0..cols+1] real;   // current temperatures
var Tnew: [0..rows+1,0..cols+1] real;    // newly computed temperatures
T[1..rows,1..cols] = 25;    // set the initial temperature

config const rowtasks = 3, coltasks = 4;
const nr = rows / rowtasks;
const rr = rows - nr*rowtasks;
const nc = cols / coltasks;
const rc = cols - nc*coltasks;

writeln('Temperature at iteration ', 0, ': ', T[iout,jout]);
delta = tolerance*10;    // some safe initial large value
var watch: Timer;
watch.start();
while (count < niter && delta >= tolerance) do {
  // boundary conditions for T
  for i in 1..rows do
    T[i,cols+1] = 80.0*i/rows;   // right side
  for j in 1..cols do
    T[rows+1,j] = 80.0*j/cols;   // bottom side
  count += 1;    // update the iteration counter
  // compute Tnew from previous T
  coforall taskid in 0..coltasks*rowtasks-1 do {
    var row1, row2, col1, col2: int;
    row1 = taskid/coltasks*nr + 1;
    row2 = taskid/coltasks*nr + nr;
    if taskid/coltasks + 1 == rowtasks then row2 += rr; // add rr rows to the last row of tasks
    col1 = taskid%coltasks*nc + 1;
    col2 = taskid%coltasks*nc + nc;
    if taskid%coltasks + 1 == coltasks then col2 += rc; // add rc columns to the last column of tasks
    for i in row1..row2 do {  // do smth for row i
      for j in col1..col2 do {   // do smth for row i and column j
	Tnew[i,j] = 0.25 * (T[i-1,j] + T[i+1,j] + T[i,j-1] + T[i,j+1]);
      }
    }
  }
  // update delta, the greatest temp difference between Tnew and T
  delta = max reduce abs(Tnew[1..rows,1..cols]-T[1..rows,1..cols]);
  T = Tnew;   // update T once all elements for Tnew are computed
  // print T[iout,jout] every nout steps
  if count%nout == 0 then writeln('Temperature at iteration ', count, ': ', T[iout,jout]);
 }
watch.stop();

writeln('Final temperature at the desired position [', iout,',', jout, '] after ', count, ' iterations is: ', T[iout,jout]);
writeln('The largest temperature difference was ', delta);
writeln('The simulation took ', watch.elapsed(), ' seconds');
