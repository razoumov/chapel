var x = 10;
config var numtasks = 2;
writeln('This is the main task: x =', x);
coforall taskid in 1..numtasks do {
  var count = taskid**2;
  writeln('this is task ', taskid, ': my value of count is ', count, ' and x is ', x);
}
writeln('This message will not appear until all tasks are done ...');
