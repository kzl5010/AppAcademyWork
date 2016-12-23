// Recursion Practice

// Write a recursive method, range, that takes a start and an end and
// returns an array of all numbers between.
//

function range(start, end) {
  if (start +1 >= end) {
    return [];
  }
  return (range(start, end-1).concat([end-1]));
}

console.log(range(1,10)); // [2,3,4,5,6,7,8,9]

// Write a recursive and an iterative Fibonacci method.
// The method should take in an integer n and return the first n Fibonacci
// numbers in an array.
//

function fib(n) {
  if (n===0){
    return [];
  } else if (n === 1) return [1]
  else if (n===2) return [1, 1]
  else {
  let fibs = fib(n-1);
  fibs.push(fibs[fibs.length-2]+fibs[fibs.length-1]);
  return fibs;
}
  // return fibs.push(fibs[fibs.length-2]+fibs[fibs.length-1]);

}

console.log(fib(6)); // [1,1,2,3,5,8]


// Write a recursive Binary Search. Note that binary search only works on
// sorted arrays. Make sure to return the location of the found object
// (or nil if not found!).

// Hint: you will probably want to use subarrays.
//

function bsearch(arr, target) {
  if (arr.length < 1){
    return -1;
  }
  let middle = Math.floor(arr.length/2);

  if (arr[middle] === target){
    return middle;
  } else if (arr[middle] > target){
    let left = arr.slice(0, middle);
    return bsearch(left, target);
  } else {
    let right = arr.slice(middle+1);
    if (bsearch(right, target) !== -1) return bsearch(right, target)+middle+1;
    return bsearch(right, target);
  }

}

console.log(bsearch([1, 2, 3], 1)); // => 0
console.log(bsearch([2, 3, 4, 5], 3)); // => 1
console.log(bsearch([2, 4, 6, 8, 10], 6)); // => 2
console.log(bsearch([1, 3, 4, 5, 9], 5)); // => 3
console.log(bsearch([1, 2, 3, 4, 5, 6], 6)); // => 5
console.log(bsearch([1, 2, 3, 4, 5, 6], 0)); // => -1
console.log(bsearch([1, 2, 3, 4, 5, 7], 6)); // => -1

// Write a recursive MergeSort
// hint: The base cases are for arrays of length zero or one.

function mergeSort(array) {
  if (array.length < 2) return array;
  let middle = Math.floor(array.length/2);
  let left = array.slice(0, middle);
  let right = array.slice(middle);
  return merge(mergeSort(left), mergeSort(right));

}

function merge(left, right) {
  let results = []
  while (left.length > 0 && right.length > 0){
    left[0] > right[0] ? results.push(right.shift()) : results.push(left.shift());
  }
  return results.concat(left).concat(right);

}

console.log(mergeSort([192,28,43,29,1,2,200,4])); // [1,2,4,28,29,43,192,200]


// Write a method, subsets, that will return all subsets of an array.
//

function subsets(array) {
  if (array.length === 0) {
    return [[]];
  }
  let first = array[0];
  let subsubSets = subsets(array.slice(1));
  let newSubsets = subsubSets.map(subsubSet=>[first].concat(subsubSet));
  return subsubSets.concat(newSubsets).sort().reverse();
}
//
console.log(subsets([])); // => [[]]
console.log(subsets([1])); // => [[], [1]]
console.log(subsets([1, 2])); // => [[], [1], [2], [1, 2]]
console.log(subsets([1, 2, 3])); // => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
