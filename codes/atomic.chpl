var lock1, lock2: atomic int;
config const numtasks = 5;
lock1.write(0);    // lock = 0
lock2.write(0);    // lock = 0
coforall taskid in 1..numtasks {
  writeln('greetings from task ', taskid, '... I am waiting for all tasks to say hello');
  lock1.add(1);    // taskid add 1 to lock
  lock1.waitFor(numtasks);  // wait for lock=numtasks, i.e. all tasks to say hello
  writeln('task ', taskid, ' is done');

  lock2.add(1);      // task id says hello and atomically subtracts 1 from lock
  lock2.waitFor(numtasks);   // then it waits for lock to be equal 0 (which will happen when all tasks say hello)
  writeln('task ', taskid, ' is really done ...');

}
