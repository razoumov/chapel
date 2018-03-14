var counter = 0;
forall i in 1..1000 with (+ reduce counter) { // go in parallel through all 1000 numbers
  counter = +i;
}
writeln("actual number of threads = ", counter);
