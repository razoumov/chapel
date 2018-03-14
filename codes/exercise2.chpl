use Random;
config const nelem = 1e8: int;
var x: [1..nelem] real;
fillRandom(x);   // fill array with random numbers
var gmax = 0.0;

// // here put your code to compute gmax using coforall
// config const numtasks = 12;   // let's pretend we have 12 cores
// const n = nelem / numtasks;    // number of elements per task
// const r = nelem - n*numtasks;    // these elements did not fit into the last task
// var lmax: [1..numtasks] real;   // local maxima for each task

// coforall taskid in 1..numtasks do {
//   var start, finish: int;
//   start = (taskid-1)*n + 1;
//   finish = (taskid-1)*n + n;
//   if taskid == numtasks then finish += r;   // add r elements to the last task
//   for i in start..finish do
//     if x[i] > lmax[taskid] then lmax[taskid] = x[i];
//  }

// // put largest lmax into gmax
// for taskid in 1..numtasks do     // a serial loop
//  if lmax[taskid] > gmax then gmax = lmax[taskid];

gmax = max reduce x;   // 'max' is one of the reduce operators

writeln('the maximum value in x is :', gmax);
