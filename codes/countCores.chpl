use Memory.Diagnostics;
writeln("locale #", here.id, "...");
writeln("  ...is named: ", here.name);
writeln("  ...has ", here.numPUs(), " processor cores");
writeln("  ...has ", here.physicalMemory(unit=MemUnits.GB, retType=real), " GB of memory");
writeln("  ...has ", here.maxTaskPar, " maximum parallelism");

var count = 0;
forall i in 1..1000 with (+ reduce count) {   // parallel loop
  count = 1;
}
writeln('actual number of threads = ', count);
