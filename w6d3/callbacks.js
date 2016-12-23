Function.prototype.myBind = function (ctx, ...bindArgs) {
  return (...callArgs)=> {return this.apply(ctx, bindArgs.concat(callArgs))}
};



// Write your own myBind(context) method. Add it to Function.prototype.
