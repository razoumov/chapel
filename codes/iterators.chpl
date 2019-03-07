iter multiloop(n: int) {
  for i in 1..n do
    for j in 1..n do
      yield (i, j);
}
for ij in multiloop(5) do
  writeln(ij);


iter far(n: int) {
  for i in 0..9 do
    yield i*100..i*100+2;
}
for i in far(10) do
  write(i, ' ');
writeln();
