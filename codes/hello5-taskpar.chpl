config const numTasks = here.maxTaskPar;
coforall tid in 0..#numTasks do  // create numTasks distinct tasks
  writeln("Hello, world! (from task " + tid + " of " + numTasks + " on locale " + here.name + ")");
