var x = 1;
config var numtasks = 2;
var messages: [1..numtasks] string;
writeln('This is the main task: x = ', x);
coforall taskid in 1..numtasks do {
  var c = taskid**2;
  messages[taskid] = 'this is task ' + taskid + ': my value of c is ' + c + ' and x is ' + x;  // add to a string
}
writeln('This message will not appear until all tasks are done ...');
for i in 1..numtasks do  // serial loop, will be printed in sequential order
  writeln(messages[i]);
