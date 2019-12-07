//EXERCISE 1
  // 1. Write a function that takes in an array with names and returns a new one.
   //The new array should be the same as the previous one
   // except that it should've changed your name into Perry the Platypus

let classRoom = [
    "james",
    "giorgio",
    "mayank",
    "amy",
    "manouk",
    "antonio",
    "anne-marie",
    "minatsu",
    "jaron",
    "augusta",
    "yuliya",
    "olesya"
 ];


function changename (array){
    let newArray=[];

    for (i=0; i<array.length; i++){
        if (array[i] == "mayank") {
            newArray.push("mayank is sultan");}
        else {
                newArray.push(array[i]);
            }

        }
    return newArray;
}



console.log(changename(classRoom));

//Write the same code using map function 

let classRoom = [
    "james",
    "giorgio",
    "mayank",
    "amy",
    "manouk",
    "antonio",
    "anne-marie",
    "minatsu",
    "jaron",
    "augusta",
    "yuliya",
    "olesya"
 ];
const newArray = classRoom.map(function (name){
    if (name=='mayank') name = "Mayank is Sultan"
    return name;
});


console.log(newArray);


//Use .map to return a new array where all the first letters of the names in the classRoom array have been capitalised.



let classRoom = [
    "james",
    "giorgio",
    "mayank",
    "amy",
    "manouk",
    "antonio",
    "anne-marie",
    "minatsu",
    "jaron",
    "augusta",
    "yuliya",
    "olesya"
 ];
const newArray = classRoom.map(function (name){
    if (name=='mayank') return "Mayank is Sultan"
    return name;
});


// use .map to return a new array where all the first letters of the names in the classRoom array have been capitalised.


let classRoom = [
    "james",
    "giorgio",
    "mayank",
    "amy",
    "manouk",
    "antonio",
    "anne-marie",
    "minatsu",
    "jaron",
    "augusta",
    "yuliya",
    "olesya"
 ];

 const newArray = classRoom.map(function (name) {
     firstletter = name.charAt(0).toUpperCase(); 
     restofletter = name.slice(1); 
     return firstletter+restofletter; 
})


console.log(newArray);

function normal(param) {
    //body of func
}

const anonymous = function(param) {
    //body
}

const arrow = (param) => {
    //body
}


//Filter 

let classRoom = [
    "james",
    "giorgio",
    "mayank",
    "amy",
    "manouk",
    "antonio",
    "anne-marie",
    "minatsu",
    "jaron",
    "augusta",
    "yuliya",
    "olesya"
 ];


 const newArray = classRoom.filter(name => name != "mayank")

 console.log(newArray);


 //Return Array with 
 var numbers = [1,3,4,6,8,122,9];

 const newnumbers = numbers.filter(numbers => numbers%2 === 0); 

 console.log(newnumbers);


 //Reduce function



 //sort and compare 

 let classRoom = [
    "james",
    "giorgio",
    "mayank",
    "amy",
    "manouk",
    "antonio",
    "anne-marie",
    "minatsu",
    "jaron",
    "augusta",
    "yuliya",
    "olesya"
 ];

 const compare = (a,b) => {
     if (a<b) return -1; 
     else if (a>b) return 1;
     else return 0;
 }

 sortedClassroom = classRoom.sort(compare)
 
 console.log(sortedClassroom);