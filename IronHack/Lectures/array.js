//array


// let fruits = ['mango', 'apple', 'peach', 'grapes'];

// fruits.push('papaya')

// fruits.splice(2,2)

// console.log(fruits)


// fruits.forEach(function fruit(fruits){
//     console.log(fruits)
// })

// function sum(num){
//     return num+10
// }


// console.log(printfruits(fruits))

function makecoffee(callback){
setTimeout(function(){
    console.log('Coffee is ready')
    callback()
}, 2000)
}


function servecoffee(){
    console.log('Coffee is Served')}

makecoffee(servecoffee);

