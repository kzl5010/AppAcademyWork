function Cat(name, owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  console.log(`${this.owner} loves ${this.name}`);
};

Cat.prototype.cuteStatement = function() {
  console.log(`Everyone loves ${this.name}`);
};

let c1 = new Cat("fluffy", "vinit");
let c2 = new Cat("fzz", "Buzz");
let c3 = new Cat("namer", "namee");

c1.cuteStatement();
c2.cuteStatement();
c3.cuteStatement();

Cat.prototype.meow = function () {
  console.log("meow");
};

c1.meow();

c2.meow = function() {
  console.log("meowwww");
};

c2.meow();
