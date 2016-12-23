
function myEach(arr, cb) {
  for (let i = 0; i < arr.length; i++){
    cb(arr[i]);
  }
}

// myEach([1,2,3,4,5,6], function(x){
//   console.log(x*2);
// })

Array.prototype.myEach = function(cb) {
  for (let i = 0; i < this.length; i++){
    cb(this[i]);
  }
};



function myMap(arr, cb) {
  let result = [];
  myEach(arr, function(x){
    result.push(cb(x));
  });
  return result;
}

// [1,2,3,4,5,6].myEach(function(x){
//   console.log(x*2);
// })

Array.prototype.myMap = function(cb) {
  let result = [];
  this.myEach(function(x){
    result.push(cb(x));
  });
  return result;
};

// console.log(([1,2,3,4,5,6].myMap((x)=>x**3)));
// As the exercise describes, start the accumulator variable with the
// first value. Iterate through the rest.

function myInject(ar, cb, accum) {
  let i = 0;
  if (accum === undefined) {
    i = 1;
    accum = ar[0];
  }
  for (i; i < ar.length; i++){
    accum = cb(accum, ar[i]);
  }
  return accum;

}


Array.prototype.myInject = function(cb, accum) {
  let i = 0;
  if (accum === undefined) {
    i = 1;
    accum = this[0];
  }
  for (i; i < this.length; i++){
    accum = cb(accum, this[i]);
  }
  return accum;

}


console.log([1,2,3,4].myInject(((a, b)=>b**a)));
// console.log(([1,2,3,4,5,6].myMap((x)=>x**3)));
