var x = 0;
writeln('This is the main thread, my value of x is ', x);
cobegin {
  {
    var x = 5;
    writeln('this is task 1, my value of x is ', x);
  }
  writeln('This is task 2, my value of x is ', x);
}
writeln('This message will not appear until all tasks are done!');
