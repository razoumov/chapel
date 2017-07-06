const pi = 3.14159265358979323846, n = 1000000;
var i: int, h: real, sum: real = 0;
h = 1.0 / n;
forall i in 1..n with (+ reduce sum) {
  var x = h * (i-0.5);
  sum += 4.0 / (1.0+x**2);
}
sum *= h;
writef("%i  %.12n  %.6n\n", n, sum, abs(sum-pi));

// try timing this with different number of threads, and then changing forall to coforall
