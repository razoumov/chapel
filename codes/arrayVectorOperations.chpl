var A: [1..5] string = [i in 1..5] ''+i;
assert(A.domain == {1..5});
assert(A[1] == '1');
writeln("A was initialized to: ", A);
A.push_front('a');
A.push_back('b');
assert(A.domain == {0..6});
writeln("After adding to the front and back A is: ", A);
A.insert(2, 'q');
A.insert(3, 'w');
A.insert(4, 'e');
assert(A.domain == {0..9});
writeln("After inserting some new values, A is: ", A);
var (found, idx) = A.find('q');
if found then
  writeln("Found it at index: ", idx);
else
  writeln("Didn't find 10");
writeln("The sum of elements in A is ", + reduce A);
