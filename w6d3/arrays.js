// Create an unique method for arrays
//

function myUniq(arr) {
  let results = [];
  arr.forEach( (elem) => {
    if (results.indexOf(elem) === -1){
      results.push(elem);
    }
  })
  return results;

}
console.log(myUniq([1, 1, 2, 2, 3, 3, 4, 4, 5, 5])); // [1,2,3,4,5]

// Write a unique method for arrays directly on the array class
//

Array.prototype.myUnique = function () {
  let results = [];
  this.forEach( (elem) => {
    if (results.indexOf(elem) === -1){
      results.push(elem);
    }
  })
  return results;

}

console.log([1, 1, 2, 2, 3, 3, 4, 4, 5, 5].myUnique()); // [1,2,3,4,5]


// Write a new twoSum(Array) method that finds all pairs of
// positions where the elements at those positions sum to zero.
//
//

function twoSum(arr) {
  let results = [];
  for (var i = 0; i < arr.length; i++) {
    for (let j = i+1; j< arr.length; j++) {
      if (arr[i]+arr[j]===0){
        results.push([i, j]);
      }
    }

  }
  return results;

}

console.log(twoSum([-1, 0, 2, -2, 1])); // => [[0, 4], [2, 3]]

// Write a Two sum

Array.prototype.twoSum = function () {

  let results = [];
  for (var i = 0; i < this.length; i++) {
    for (let j = i+1; j< this.length; j++) {
      if (this[i]+this[j]===0){
        results.push([i, j]);
      }
    }

  }
  return results;
}

console.log([-1, 0, 2, -2, 1].twoSum()); // => [[0, 4], [2, 3]]

// Write a method, my_transpose, which will convert between the
// row-oriented and column-oriented representations.
//
//

function myTranspose(arr) {
  let results = [];
  for (let i = 0; i < arr.length; i++) {
    results.push([]);
  }

  for (let i = 0; i < arr.length; i++) {
    for (let j = 0; j < arr[0].length; j++) {
      results[j].push(arr[i][j]);
    }
  }
  return results;

}

console.log(myTranspose([
   [0, 1, 2],
   [3, 4, 5],
   [6, 7, 8]
 ]));
// => [[0, 3, 6],
//    [1, 4, 7],
//    [2, 5, 8]]
