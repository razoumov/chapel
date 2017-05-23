use CyclicDist; // use standard Cyclic distribution module to access a domain map with round-robin
  		// distribution of indices to locales
config const numMessages = 100;
const MessageSpace = {1..numMessages} dmapped Cyclic(startIdx=1); // define a distributed domain (an
								  // index set) starting in round-robin
								  // with locale #0
forall msg in MessageSpace do
  writeln("Hello, world! (from iteration ", msg, " of ", numMessages, 
	  " owned by locale ", here.id, " of ", numLocales, ")");
