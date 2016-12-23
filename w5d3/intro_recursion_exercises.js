var range = function(start, ender) {
  if (start > ender){
    return [];
  }
  else {
    let results = [];
    results.push(start);
    results = results.concat(range(start+1, ender));
    return results;
  }
};

console.log(range(11, 10));

var recursiveSum = function(arr) {
  if (arr.length <= 1) {
    return arr[0];
  }
  else {
    let sum = 0;
    sum = arr[0] + recursiveSum(arr.slice(1));
    return sum;
  }


};

console.log(recursiveSum(range(1,10)));

var iterativeSum = function(arr) {
  let sum = 0;
  for (let i = 0; i < arr.length; i++) {
    sum += arr[i];
  }
  return sum;
};

console.log(iterativeSum(range(1, 10)));

var exponentiation = function(base, power) {
  if (power === 0) {
    return 1;
  }
  else if (power === 1 ) {
    return base;
  }
  else {
    return base * exponentiation(base, power-1);
  }
};

var fibonacci = function(n) {
  if (n === 0) {
    return [];
  } else if (n === 1){
    return [1];
  } else if (n === 2) {
    return [1, 1];
  } else {
    let num = fibonacci(n -1).pop() + fibonacci(n - 2).pop();
    return (fibonacci(n - 1).concat([num]));
  }
};

console.log(fibonacci(5));

console.log(exponentiation(2, 4));

var bsearch = function(arr, target) {
  if (arr.length === 1 && arr[0] === target) {
    return 0;
  } else if (arr.length === 1 && arr[0] !== target) {
    return null;
  } else {
    let m = Math.floor(arr.length / 2);
    if (target > arr[m]) {
      if (bsearch(arr.slice(m+1, arr.length), target) === null)
        return null;
      else
        return m + 1 + bsearch(arr.slice(m+1, arr.length), target);
    } else if (target < arr[m]){
      return bsearch(arr.slice(0, m), target);
    } else {
      return m;
    }
  }
};

console.log(bsearch([1, 2, 3], 1));
console.log(bsearch([2, 3, 4, 5], 3));
console.log(bsearch([2, 4, 6, 8, 10], 6));
console.log(bsearch([1, 3, 4, 5, 9], 5));
console.log(bsearch([1, 2, 3, 4, 5, 6], 6));
console.log(bsearch([1, 2, 3, 4, 5, 6], 0));
console.log(bsearch([1, 2, 3, 4, 5, 7], 6));

Array.prototype.myEach = function (func) {
  for (let i = 0; i < this.length; i++) {
    func(this[i]);
  }
};

Array.prototype.mySelect = function (func) {
  let result = [];
  this.myEach(function(x) {
    if (func(x)) {
      result.push(x);
    }
  });
  return result;
};


var makeChange = function(target, coins) {
  if (target < coins[0]){
    return [];
  } else if (target === coins[0]) {
    return [coins[0]];
  }
  for (let i = 0; i < coins.length; i++) {
    let result = [];
    result.push(coins[i]);
    let newTarget = target - coins[i];
    result = result.concat(makeChange(newTarget, coins.mySelect(function(myFunctionCoin) {
      return myFunctionCoin <= newTarget;
    })));
    return result;
  }
};

console.log(makeChange(14, [10, 7, 1]));

var mergeSort = function (arr) {
  if (arr.length <= 1) {
    return arr;
  } else {
    let m = Math.floor(arr.length/2);
    let left = mergeSort(arr.slice(0, m));
    let right = mergeSort(arr.slice(m));
    return merge(left, right);
  }
};

var merge = function(arr1, arr2) {
  let i = 0;
  let j = 0;
  let merged = [];
  while (i < arr1.length && j < arr2.length) {
    if (arr1[i] <= arr2[j]) {
      merged.push(arr1[i]);
      i++;
    } else {
      merged.push(arr2[j]);
      j++;
    }
  }
  merged = merged.concat(arr1.slice(i));
  merged = merged.concat(arr2.slice(j));
  return merged;
};

console.log(mergeSort([8, 2, 7, 1, -1, 9]));


var subsets = function(arr) {
  if (arr.length === 1) {
    return [arr];
  }
  else {
    let results = [];
    let subs = subsets(arr.slice(1));
    let first = arr[0];
    for (let i = 0; i < subs.length; i++) {
      results.push(subs[i]);
      results.push(subs[i].concat([first]));
    }
    results.push([first]);
    return results;
  }
};

console.log(subsets([1, 2, 3]));
