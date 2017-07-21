use Memory;

// writeln("It began running on locale #", here.id);
// writeln();

// var MyLocaleArray: [1..10] locale;
// for i in 1..10 do
//   MyLocaleArray[i] = Locales[(i-1)%numLocales];
// for i in 1..10 do
//   on MyLocaleArray[i] do
//     writeln("MyLocaleArray[", i, "] is really locale ", here.id);
// writeln();

writeln("there are ", numLocales, " locales");
for loc in Locales do   // this is still a serial program
  on loc {   // simply move the lines inside to locale loc
    writeln("locale #", here.id, "...");
    writeln("  ...is named: ", here.name);
    writeln("  ...has ", here.numPUs(), " processor cores");
    writeln("  ...has ", here.physicalMemory(unit=MemUnits.GB, retType=real), " GB of memory");
    writeln("  ...has ", here.maxTaskPar, " maximum parallelism");
  }

// var x: int = 2;
// on Locales[1 % numLocales] { // if numLocales=1 run on Locales[0], otherwise on Locales[1]
//   var y: int = 3;
//   writeln("From locale ", here.id, ", x = ", x, " and y = ", y);
//   on Locales[0] {
//     writeln("From locale 0, x = ", x, " and y = ", y);
//   }
// }

// var x: int = 2;
// on Locales[1 % numLocales] { // if numLocales=1 run on Locales[0], otherwise on Locales[1]
//   var y: int = 3;
//   writeln("x is stored on locale ", x.locale.id, ", while y lives on ", y.locale.id);
//   writeln((x,y));
// }

