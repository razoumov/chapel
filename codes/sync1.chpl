var x = 0;
writeln('This is the main thread starting a synchronous task');
sync {
  begin {
    var count = 0;
    while count < 10 {
      count += 1;
      writeln('thread 1: ', x + count);
    }
  }
}
writeln('The first task is done ...');
writeln('This is the main thread starting an asynchronous task');
begin {
  var count = 0;
  while count < 10 {
    count += 1;
    writeln('thread 2: ', x + count);
  }
}
writeln('This is the main thread, I am done!');
