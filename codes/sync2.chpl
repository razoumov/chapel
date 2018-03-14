var x: sync int;
writeln('This is the main task launching a new task');
begin {
  for i in 1..10 do
    writeln('this is the new task working: ', i);
  x = 2;
  writeln('New task finished');
}
writeln('this is the main task after launching new task .. wait until x is full');
x;    // read x, but don't do anything with it
writeln('and now it is done');
