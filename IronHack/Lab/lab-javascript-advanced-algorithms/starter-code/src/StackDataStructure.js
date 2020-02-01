function Stack() {
    this.stack = [];
    this.top = 0;
    this.push = push;
    this.pop = pop;
    this.maxsize = 10;

 }


 function push(element) {
    this.stack[this.top++] = element;
 }


 function pop() {
    return this.stack.pop();
 }


//Testing the Class
var s = new Stack();
s.push("I");
s.push("R");
s.push("O");
s.push("N");

//How does the stack look like 
console.log(s.stack);

//Pop
var popped = s.pop();

//Return the results
console.log("The popped Element is " + popped);

console.log(s.stack);