// Array.prototype.myUniq = function() {
//   let de_dup = [];
//   this.forEach(function(elem) {
//     if (de_dup.indexOf(elem) === -1) {
//       de_dup.push(elem);
//     }
//   });
//   return de_dup;
// };
//
//
// console.log([1, 2, 1, 3, 3].myUniq());
//
// Array.prototype.twoSum = function() {
//   let results = [];
//   for (let idx = 0; idx < this.length - 1 ; idx++) {
//     for (let idx2 = idx+1; idx2 < this.length; idx2++) {
//       if (this[idx] + this[idx2] === 0) {
//         results.push([idx, idx2]);
//       }
//     }
//
//   }
//   return results;
// };
//
//
// console.log([-1, 0, 2, -2, 1].twoSum());
//
// Array.prototype.myTranspose = function() {
//   let matrix = [];
//   let j = 0;
//   while (j < this.length) {
//     let i = 0;
//     let row = [];
//     while (i < this.length) {
//       row.push(this[i][j]);
//       i++;
//     }
//     j++;
//     matrix.push(row);
//   }
//   return matrix;
// };
//
// console.log([
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ].myTranspose());
//
  // Array.prototype.myEach = function (func) {
  //   for (let i = 0; i < this.length; i++) {
  //     func(this[i]);
  //   }
  // };

  // console.log([-1, 0, 2, -2, 1].myEach(console.log));
  //
  // Array.prototype.myInject = function (func) {
  //   let accum = this[0];
  //   for (let i = 1; i < this.length; i++) {
  //     accum = func(accum, this[i]);
  //   }
  //   return accum;
  // };

  // console.log([-1, 0, 2, -2, 1].myEach(console.log));
  //
  // Array.prototype.myInject = function (func) {
  //   let accum = this[0];
  //   this.myEach(function(x) {
  //     accum = func(accum, x);
  //   });
  //   return accum;
  // };
  //
  //
  // //
  // console.log([-1, 2, 2, -5, 1].myInject(function(x, y) {
  //   return x * y;
  // }));
  //
  // Array.prototype.myMap = function (func) {
  //   let results = [];
  //   this.myEach(function(x) {
  //     results.push(func(x));
  //   });
  //   return results;
  // };

  // Array.prototype.myMap = function (func) {
  //   let results = [];
  //   for (let i = 0; i < this.length; i++) {
  //     results.push(func(this[i]));
  //   }
  //   return results;
  // };
  // console.log([-1, -2, -3, 4, 5].myMap(function(x) { return x *2; }));
  //
  // Array.prototype.mySelect = function (func) {
  //   let result = [];
  //   this.myEach(function(x) {
  //     if (func(x)) {
  //       result.push(x);
  //     }
  //   });
  //   return result;
  // };
  //
  // console.log([2, 1, 4, 5, 3, 6].mySelect(function(x) {
  //   return x % 2 === 0;
  // }));
  //

  // var factors = function(number) {
  //   let facs = [];
  //   for(let i = 1; i <= number; i++) {
  //     if (number % i === 0){
  //       facs.push(i);
  //     }
  //   }
  //   return facs;
  // };
  //
  // console.log(factors(16));
  //
  // Array.prototype.bubbleSort = function() {
  //   let sorted = false;
  //   while (!sorted) {
  //     sorted = true;
  //     for (let i = 0; i < this.length-1; i++) {
  //       if (this[i] > this[i+1]) {
  //         let temp = this[i];
  //         this[i] = this[i+1];
  //         this[i+1] = temp;
  //         sorted = false;
  //       }
  //     }
  //   }
  //
  // };
  //
  // let arr = [-1, 2, 2, -5, 1];
  // arr.bubbleSort();
  // console.log(arr);

  var substrings = function(str){
    let results = [];
    for(let i = 0; i < str.length -1 ; i++) {
      for (let j = i+1; j < str.length; j++) {
        results.push(str.substring(i, j));
      }
    }
    return results;
  };

console.log(substrings('hello'));
