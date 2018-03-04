var x = 0;
writeln("This is the main thread starting a synchronous task");

begin {
  sync {
    var c = 0;
    while c < 10 {
      c += 1;
      writeln('thread 1: ', x + c);
    }
  }
}
writeln("The first task is done ...");

writeln("This is the main thread starting an asynchronous task");

begin {
  var c = 0;
  while c < 10 {
    c += 1;
    writeln('thread 2: ', x + c);
  }
}

writeln('This is main thread, I am done ...');