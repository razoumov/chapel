var x: sync int;
writeln("this is main task launching a new task");
begin {
  for i in 1..10 do
    writeln("this is new task working: ", i);
  x = 2;
  writeln("New task finished");
}

writeln("this is main task after launching new task ... I will wait until  it is done");
//x;
var a = x; writeln(a);
x = 10;
a = x; writeln(a);
writeln("and now it is done");
