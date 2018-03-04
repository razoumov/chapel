var lock1, lock2: atomic int;
const numtasks = 5;
lock1.write(0);   // the main task set lock to zero
lock2.write(0);   // the main task set lock to zero
coforall id in 1..numtasks {
  writeln("greetings form task ", id, "... I am waiting for all tasks to say hello");
  lock1.add(1);              // task id says hello and atomically adds 1 to lock
  lock1.waitFor(numtasks);   // then it waits for lock to be equal numtasks (which will happen when all tasks say hello)
  writeln("task ", id, " is done ...");
  lock2.add(1);
  lock2.waitFor(numtasks);
  writeln("task ", id, " is really done ...");  
}
