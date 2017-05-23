config const printLocaleName = true;
config const tasksPerLocale = 1;

/* writeln(Locales); */
/* writeln(tasksPerLocale); */
/* halt('all done'); */

coforall loc in Locales {
  on loc {
    coforall tid in 0..#tasksPerLocale { // create tasksPerLocale distinct tasks
      var message = "Hello, world! (from ";
      if (tasksPerLocale > 1) then
        message += "task " + tid + " of " + tasksPerLocale + " on ";
      message += "locale " + here.id + " of " + numLocales;
      if printLocaleName then message += " named " + loc.name;
      message += ")";
      writeln(message);
    }
  }
}
