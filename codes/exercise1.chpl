var x = 1;
config var numthreads = 2;
var messages: [1..numthreads] string;
writeln('This is the main task: x = ', x);
coforall taskid in 1..numthreads do {
  var c = taskid**2;
  messages[taskid] = 'this is task ' + taskid:string + ': my value of c is ' + c:string + ' and x is ' + x:string;  // add to a string
}
writeln('This message will not appear until all tasks are done ...');
for i in 1..numthreads do  // serial loop, will be printed in sequential order
  writeln(messages[i]);
