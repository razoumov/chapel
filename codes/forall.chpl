var counter = 0;
forall i in 1..1000 with (+ reduce counter) { // go in parallel through all n^2 elements
  counter += i;
}
writeln("counter = ", counter);
