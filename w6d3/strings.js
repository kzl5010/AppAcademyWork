

function isSubstring(searchString, subString) {
  if (searchString.indexOf(subString)===-1) return false;
  return true;
}

console.log(isSubstring("time to program", "time")); // true
console.log(isSubstring("Jump for joy", "joys")); // false

// Write a function that takes three strings - a verb, an adjective, and a
// noun - uppercases and interpolates them into the sentence
// "We shall VERB the ADJECTIVE NOUN".

function madLib(verb, adj, noun) {
  return `We shall ${verb} the ${adj} ${noun}`;
}

console.log(madLib('make', 'best', 'guac')); // "We shall MAKE the BEST GUAC."
