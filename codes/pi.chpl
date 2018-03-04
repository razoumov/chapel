const pi = 3.14159265358979323846;
config const n = 1000;

var h, sum = 0.0, i: int;
h = 1.0 / n;

forall i in 1..n with (+ reduce sum) {
  var x = h * ( i - 0.5 );
  sum += 4.0 / ( 1.0 + x**2);
}

sum *= h;
writef("%.12n   %.6n\n", sum, abs(sum-pi));
