// Opaque domains and arrays are a special case of associative domains and arrays, without indices.

// var people: domain(opaque); // opaque domain, its indices have no values

// // these three definitions are identical
// var person1 = people.create();  // person1 inferred to be of type index(people)
// var person2: index(people) = people.create();
// var person3: index(opaque) = people.create();

// var name: [people] string;   // array on top of this domain

// name[person1] = "Barry";
// name[person2] = "Bill";
// name[person3] = "Bob";

// writeln("people is: ", people);
// writeln("name is: ", name);
// writeln("name[person2] is: ", name[person2]);
// writeln();

// for person in people do   // no particular order
//   writeln("name[person] = ", name[person]);
// writeln();

// writeln("name (sorted) is: ", name.sorted());
// writeln();

// var father: [people] index(people);   // an array on domain indices on top of this domain
// father(person2) = person1;
// father(person3) = person1;

// for person in people {
//   write("father(", name[person], ") is ");
//   if (father[person] == nil) {
//     writeln("unknown");
//   } else {
//     writeln(name[father[person]]);
//   }
// }
// writeln();

// config const maxChildren = 16;
// var numChildren: [people] int;
// var children: [people] [1..maxChildren] index(people);

// proc addChild(parent: index(people), child: index(people)) {
//   const childnum = numChildren[parent] + 1;
//   numChildren[parent] += 1;
//   children[parent][childnum] = child;
// }

// addChild(person1, person2);
// addChild(person1, person3);

var vertices, edges: domain(opaque); // two opaque domains, their indices have no values
config const numVertices = 5;

var tag: [vertices] string;        // an array of strings
var numOutEdges: [vertices] int;     // an array of integers
var vertexWeight: [vertices] real;   // an array of reals
var outEdges: [vertices] [1..numVertices] index(edges);   // an array of opaque arrays
var edgeWeight: [edges] real;
var from, to: [edges] index(vertices);   // for each edge two vertices

proc createRandomGraph() {
  use Random;
  var myRandNums = makeRandomStream(real, seed=314159265, algorithm=RNG.NPB);
  // allocate all the vertices and assign them tags and random weights
  for i in 1..numVertices {
    var newVertex = vertices.create();
    tag[newVertex] = "v" + i;
    vertexWeight[newVertex] = myRandNums.getNext();
  }
  // iterate over all pairs of vertices
  for vi in vertices {
    for vj in vertices {
      // roll a random number; if [0.5-1.0], add edge (vi, vj)
      if (myRandNums.getNext() > 0.5) {
	// allocate a new edge and give it a random weight
	var newEdge = edges.create();
	edgeWeight[newEdge] = myRandNums.getNext();
	// increment the number of out edges for the source vertex vi
	numOutEdges[vi] += 1;
	// add the edge to its list of out edges
	outEdges[vi][numOutEdges[vi]] = newEdge;
        // store the source and sink vertices for the edge
	from[newEdge] = vi;
	to[newEdge] = vj;
      }
    }
  }
}

createRandomGraph();

writeln("Edge-centric view of random graph");
writeln("----------------------------------");
for e in edges do
  // for each edge, print out its weight, source, and sink
  writeln("an edge with weight ", edgeWeight(e), " links from ", tag[from[e]], " to ", tag[to[e]]);
writeln();
