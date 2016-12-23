// Write a sum function that takes any number of arguments:

function mySum(...arguments) {
  return arguments.reduce( (a, b) => a+b);
}

console.log(mySum(1, 2, 3, 4) === 10);
console.log(mySum(1, 2, 3, 4, 5) === 15);
