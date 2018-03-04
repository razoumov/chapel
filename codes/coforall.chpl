var x = 1;
config var numtasks = 2;
var messages: [1..numtasks] string;
writeln("This is the main task: x = ", x);
coforall taskid in 1..numtasks do {
  var c = taskid + 1;
  var s = "this is task " + taskid + ": my value of c is " + c + ' and x is ' + x;
  messages[taskid] = s;
}
for i in 1..numtasks do
  writeln(messages[i]);
writeln("This message won't appear until all tasks are done ...");
