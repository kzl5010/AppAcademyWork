// Iterations

function bubbleSort(arr) {
  let sorted = false;

  while(!sorted){
    sorted = true;
    for (var i = 0; i < arr.length; i++) {
      if(arr[i]>arr[i+1]){
        let temp = arr[i+1];
        arr[i+1] = arr[i];
        arr[i] = temp;
        sorted = false;
      }
    }
  }
  return arr;

}

// console.log(bubbleSort([192,28,43,29,1,2,200,4])); // [1,2,4,28,29,43,192,200]

Array.prototype.bubbleSort = function() {
  let sorted = false;

  while(!sorted){
    sorted = true;
    for (var i = 0; i < this.length; i++) {
      if(this[i]>this[i+1]){
        let temp = this[i+1];
        this[i+1] = this[i];
        this[i] = temp;
        sorted = false;
      }
    }
  }
  return this;

};

// console.log([192,28,43,29,1,2,200,4].bubbleSort()); // [1,2,4,28,29,43,192,200]


function substrings(string) {
  let results = [];
  for (var i = 0; i < string.length; i++) {
    for (var j = 0; i+j <= string.length; j++) {
      if (string.slice(i, i+j)===""){
      } else {
      results.push(string.slice(i, i+j));
    }
    }
  }
  return results;

}

// console.log(substrings("hello")); // ['h','he','hel','hell','hello','e','el','ell','ello','l','ll','llo','l','lo','o']

String.prototype.substrings = function (){
  let results = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = 0; i+j <= this.length; j++) {
      if (this.slice(i, i+j)===""){
      } else {
      results.push(this.slice(i, i+j));
    }
    }
  }
  return results;

}

console.log("hello".substrings()); // ['h','he','hel','hell','hello','e','el','ell','ello','l','ll','llo','l','lo','o']
