var T: [1..100,1..100] real; // define T as a 2D array
var x, y: real;

for (i,j) in T.domain { // serial iteration
  x = ((i:real)-0.5)/100.0;
  y = ((j:real)-0.5)/100.0;
  T[i,j] = exp(-((x-0.5)**2 + (y-0.5)**2)/0.01); // narrow gaussian peak
}

for idx in T.domain do
  writeln((idx,T[idx[1],idx[2]]));

forall idx in T.domain do // reasonable or "--dataParTasksPerLocale=..." number of tasks
  writeln((idx,T[idx[1],idx[2]]));

coforall (i,j) in T.domain by (20,20) { // 5x5 decomposition into 20x20 blocks => 25 tasks
  for k in i..i+19 { // serial loop inside each block
    for l in j..j+19 do {
      writeln((i,j,k,l));
    }
  }
}
