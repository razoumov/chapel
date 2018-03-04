use Time;
config const rows = 100, cols = 100;   // number of rows and columns in our matrix
config const niter = 500;   // max number of iterations
config const iout = 1, jout = cols;   // some row and column numbers

var delta: atomic real;    // the greatest temperature difference between Tnew and T

config const tolerance = 1e-4: real;   // temperature difference tolerance
config const nout = 20: int;    // T[iout,jout] will be printed every nout steps

writeln('Working with a matrix ', rows, 'x', cols, ' to ', niter, ' iterations or dT below ', tolerance);

var T: [0..rows+1,0..cols+1] real;   // current temperatures
var Tnew: [0..rows+1,0..cols+1] real;    // newly computed temperatures
T[1..rows,1..cols] = 25;    // set the initial temperature

config const rowtasks = 3, coltasks = 4;   // let's pretend we have 12 cores
const nr = rows / rowtasks;   // number of rows per task
const rr = rows - nr*rowtasks; // remainder rows (did not fit into the last task)
const nc = cols / coltasks;   // number of columns per task
const rc = cols - nc*coltasks; // remainder columns (did not fit into the last task)
var lock1, lock2: atomic int;
var arrayDelta: [0..coltasks*rowtasks-1] real; // array of local delta's for each task

writeln('Temperature at iteration ', 0, ': ', T[iout,jout]);
delta.write(tolerance*10);    // some safe initial large value
var watch: Timer;
watch.start();

coforall taskid in 0..coltasks*rowtasks-1 do { // each iteration processed by a separate task
  var row1, row2, col1, col2: int;
  var count = 0: int;    // the iteration counter
  var tmp: real;   // for temporary results
  row1 = taskid/coltasks*nr + 1;
  row2 = taskid/coltasks*nr + nr;
  if taskid/coltasks + 1 == rowtasks then row2 += rr; // add rr rows to the last row of tasks
  col1 = taskid%coltasks*nc + 1;
  col2 = taskid%coltasks*nc + nc;
  if taskid%coltasks + 1 == coltasks then col2 += rc; // add rc columns to the last column of tasks
  while (count < niter && delta.read() >= tolerance) do {
    // boundary conditions for T
    for i in 1..rows do
      T[i,cols+1] = 80.0*i/rows;   // right side
    for j in 1..cols do
      T[rows+1,j] = 80.0*j/cols;   // bottom side
    count += 1;    // update the iteration counter
    // compute Tnew from previous T
    tmp = 0;
    for i in row1..row2 do {
      for j in col1..col2 do {
  	Tnew[i,j] = 0.25 * (T[i-1,j] + T[i+1,j] + T[i,j-1] + T[i,j+1]);
        tmp = max(abs(Tnew[i,j]-T[i,j]),tmp);
      }
    }
    arrayDelta[taskid] = tmp;
    lock1.add(1);   // each task atomically adds 1 to lock
    lock1.waitFor(coltasks*rowtasks*count);   // then it waits for lock to be equal coltasks*rowtasks
    // update delta, the greatest temp difference between Tnew and T
    if taskid == 0 then {
      delta.write(max reduce arrayDelta);
      if count%nout == 0 then writeln('Temperature at iteration ', count, ': ', T[iout,jout]);
    }
    T[row1..row2,col1..col2] = Tnew[row1..row2,col1..col2];   // update T once all elements for Tnew are computed
    lock2.add(1);   // each task atomically subtracts 1 from lock
    lock2.waitFor(coltasks*rowtasks*count);   // then it waits for lock to be equal 0
  }
 }
watch.stop();

writeln('Final temperature at the desired position [', iout,',', jout, '] is: ', T[iout,jout]);
writeln('The largest temperature difference was ', delta);
writeln('The simulation took ', watch.elapsed(), ' seconds');
