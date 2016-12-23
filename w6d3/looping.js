
// fizzBuzz

//  Takes an array returns a new array of every number in the array
//  that is divisible by either 3 or 5, but not both.
function fizzBuzz(array) {
  let results = [];
  for (var i = 0; i < array.length; i++) {
    if(array[i] % 5 === 0 && array[i] % 3 === 0) {}
    else if (array[i] % 5 === 0 || array[i] % 3 === 0) {
      results.push(array[i]);
    }
  }
  return results;

}

console.log(fizzBuzz([12, 15, 3, 10, 2, 30, 7])); // [12, 3, 10]


function isPrime(number) {
  if (number < 2) {
    return false;
  }

  for (let i = 2; i < number; i++){
    if (number % i === 0) return false;
  }
  return true;

}

console.log(isPrime(2)); // true
console.log(isPrime(10)); // false
console.log(isPrime(15485863)); // true
console.log(isPrime(3548563)); // false


function firstNPrimes(n) {
  let results = [];
  let counter = 2;
  while (results.length < n){
    if (isPrime(counter)){
      results.push(counter);
    }
    counter++;
  }

  return results;
}


console.log(firstNPrimes(0));

function sumOfNPrimes(n) {
  let primes = firstNPrimes(n);
  if (primes.length === 0){
    return 0;
  }
  return primes.reduce((a,b)=>a+b);
}

console.log(sumOfNPrimes(0)); // 0
console.log( sumOfNPrimes(1)); // 2
console.log(sumOfNPrimes(4)); // 17

// return true if numbers are all divisible by mod

function allOrNothing(mod, ...numbers) {
  for (var i = 0; i < numbers.length; i++) {
    if (numbers[i] % mod !== 0) return false;
  }
  return true;
}

console.log(allOrNothing(3, 9, 12, 6)); // true
console.log(allOrNothing(5, 1, 2, 10)); // false
