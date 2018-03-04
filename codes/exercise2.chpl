use Random;
config const nelem = 1e9: int;    // converting real to integer
var x: [1..nelem] real;
fillRandom(x);	// fill array with random numbers
var gmax = 0.0;

config const numtasks = 12;     // let's pretend we have 12 cores
const n = nelem / numtasks;     // number of elements per task
const r = nelem - n*numtasks;   // these did not fit into the last task
var lmax: [1..numtasks] real;   // local maximum for each task

coforall taskid in 1..numtasks do {   // each iteration processed by a separate task
  var start, finish: int;
  start  = (taskid-1)*n + 1;
  finish = (taskid-1)*n + n;
  if taskid == numtasks then finish += r;    // add r elements to the last task
  for i in start..finish do
    if x[i] > lmax[taskid] then lmax[taskid] = x[i];
 }

for taskid in 1..numtasks do     // no need for a parallel loop here
  if lmax[taskid] > gmax then gmax = lmax[taskid];

writeln("the maximum value in x is: ", gmax);



