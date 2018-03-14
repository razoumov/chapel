var x = 100;
writeln('This is the main thread starting first task');
begin {
  var count = 0;
  var x = 10;
  while count < 10 {
    count += 1;
    writeln('thread 1: ', x + count);
  }
}
writeln('This is the main thread starting second task');
begin {
  var count = 0;
  while count < 10 {
    count += 1;
    writeln('thread 2: ', x + count);
  }
}
writeln('This is the main thread, I am done!');
