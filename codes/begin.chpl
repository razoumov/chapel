var x = 0;

// writeln("This is the main thread starting first task");
// begin {
//   var c = 0;
//   while c < 10 {
//     c += 1;
//     writeln('thread 1: ', x + c);
//   }
// }

// writeln("This is the main thread starting second task");
// begin {
//   var c = 0;
//   while c < 10 {
//     c += 1;
//     writeln('thread 2: ', x + c);
//   }
// }

var c = 0;
while c > -1 {
  c += 1;
  writeln('thread 1: ', x + c);
}

writeln('This is main thread, I am done ...');
