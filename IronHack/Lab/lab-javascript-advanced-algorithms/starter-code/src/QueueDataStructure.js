class QueueDataStructure {
    constructor(){
        this.queue = [];
    }


//Add an element to the Queue 

enqueue(item) {
    return this.queue.unshift(item);
}

dequeue(){
    return this.queue.pop();
}


}

//Testing the function 
const MyQueue = new QueueDataStructure();
MyQueue.enqueue('I');
MyQueue.enqueue('R');
MyQueue.enqueue('O');
MyQueue.enqueue('N');

//Output before removing

console.log(MyQueue.queue);

MyQueue.dequeue();

//Output after the removing
console.log(MyQueue.queue);

