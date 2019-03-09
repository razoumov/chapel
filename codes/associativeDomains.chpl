// Chapel's associative domains are similar to Python's dictionaries. Today, associative domains cannot
// be distributed across multiple locales. However, a prototype domain map for this exists.

var A: domain(int);     // a domain (set) whose indices are integers
var days: domain(string);  // a domain (set) whose indices are strings
var C: domain(real);    // a domain (set) whose indices are reals

var T: [days] real; // array of reals

days += 'Mon'; // add a domain index
days += 'Tue';
T['Mon'] = 25;  // add an array value
days.add('Wed'); // add a domain index
writeln('domain = ', days);
writeln('array = ', T);

var week = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'}; // 1D domain with string indices is also a set!
for i in week do   // associative domain elements will be printed in no specific order
  writeln(i, ' ', days.member(i));
writeln('---');
for i in week.sorted() do
  writeln(i, ' ', days.member(i));

writeln({10,10}); // this 1D domain has only one element
