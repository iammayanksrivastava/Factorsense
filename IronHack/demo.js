function eatDinner(a){
    console.log("Eating Dinner");
    a();

};


function eatDesserts(){
    console.log("Eating Dessert")

};


eatDinner(eatDesserts);

let object = {
    key1: "value1",
    key2: "value2"
}

object.key3 = "value3"
console.log(object.key3)



const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

console.log(days[0]);

array.forEach(element => {
    
});

array.forEach(element => {
    
});

array = [1,2,3,4,5,6]; 

const newArray = array.map(number => number*2); 

console.log(newArray)

var cities = ["miami", "barcelona", "madrid", "amsterdam", "berlin", "sao paulo", "lisbon", "mexico city", "paris"];

const citiesNew = cities.map(city => city[0].toLocaleUpperCase()+city.slice(1));

console.log(citiesNew)


const students = [
    {
      name: "Tony Parker",
      firstProject: 80,
      secondProject: 75,
      finalExam: 90
    },
    {
      name: "Marc Barchini",
      firstProject: 84,
      secondProject: 65,
      finalExam: 65
    },
    {
      name: "Claudia Lopez",
      firstProject: 45,
      secondProject: 95,
      finalExam: 99
    },
    {
      name: "Alvaro Briattore",
      firstProject: 82,
      secondProject: 92,
      finalExam: 70
    },
    {
      name: "Isabel Ortega",
      firstProject: 90,
      secondProject: 32,
      finalExam: 85
    },
    {
      name: "Francisco Martinez",
      firstProject: 90,
      secondProject: 55,
      finalExam: 78
    },
    {
      name: "Jorge Carrillo",
      firstProject: 83,
      secondProject: 77,
      finalExam: 90
    },
    {
      name: "Miguel López",
      firstProject: 80,
      secondProject: 75,
      finalExam: 75
    },
    {
      name: "Carolina Perez",
      firstProject: 85,
      secondProject: 72,
      finalExam: 67
    },
    {
      name: "Ruben Pardo",
      firstProject: 89,
      secondProject: 72,
      finalExam: 65
    }
]


const finalGrades = students.map(theStudent => {
    const projectAvg = (theStudent.firstProject+theStudent.secondProject)/2
    const finalGrade = theStudent.finalExam*0.6 + projectAvg*0.4;

    return {
        name: theStudent.name,
        finalGrade: Math.round(finalGrade)
    }
})


console.log(finalGrades);


const numbers = [2,4,6,8];


const total = numbers.reduce((a,b) => {
    console.log("accumulator: ", a, "current value: ", b)
    return a+b;
});

console.log("Total: " ,total);



const menu = [
    { name: "Carrots", calories: 150 },
    { name: "Steak", calories: 350 },
    { name: "Broccoli", calories: 120 },
    { name: "Chicken", calories: 250 },
    { name: "Pizza", calories: 520 }
  ];
  


  // your code:
  const averageCalories = menu.reduce((sum, menu) => {
      return (sum+menu.calories)
  }, 0);
  
  
  console.log(averageCalories/menu.length);


  const product = {
    name: "AmazonBasics Apple Certified Lightning to USB Cable",
    price: 7.99,
    manufacter: "Amazon",
    reviews:
    [
      {  user: "Pavel Nedved",
        comments: "It was really usefull, strongly recommended",
        rate: 4
      },
      {  user: "Alvaro Trezeguet",
        comments: "It lasted 2 days",
        rate: 1
      },
      {  user: "David Recoba",
        comments: "Awesome",
        rate: 5
      },
      {  user: "Jose Romero",
        comments: "Good value for money",
        rate: 4
      },
      {  user: "Antonio Cano",
        comments: "It broked really fast",
        rate: 2
      },
    ]
  }


  const averageRate = product.reviews.reduce((a,b)=> {
      return a+b.rate
  },0);


console.log(averageRate/product.reviews.length)


const numbers = [1, 2, 3, 4, 5, 6];

const evenNumbers = numbers.filter(number => number%2===0);

console.log(evenNumbers);


var people = [
    { name: "Candice", age: 25 },
    { name: "Tammy", age: 30 },
    { name: "Allen", age: 20 },
    { name: "Nettie", age: 21 },
    { name: "Stuart", age: 17 },
    { name: "Bill", age: 19 }
  ];

const peopleBar = people.filter(people => people.age>=18);


console.log(peopleBar)



const places = [
    {
     title: "Awesome Suite 20' away from la Rambla",
     price: 200,
     type: "Private Room",
     pool: true,
     garage: false
    },
    {
     title: "Private apartment",
     price: 190,
     type: "Entire Place",
     pool: true,
     garage: true
    },
    {
     title: "Apartment with awesome views",
     price: 400,
     type: "Entire Place",
     pool: false,
     garage: false
    },
    {
     title: "Apartment in la Rambla",
     price: 150,
     type: "Private Room",
     pool: false,
     garage: true
    },
    {
     title: "Comfortable place in Barcelona´s center",
     price: 390,
     type: "Entire place",
     pool: true,
     garage: true
    },
    {
     title: "Room near Sagrada Familia",
     price: 170,
     type: "Private Room",
     pool: false,
     garage: false
    },
    {
     title: "Great house next to Camp Nou",
     price: 140,
     type: "Entire place",
     pool: true,
     garage: true
    },
    {
     title: "New apartment with 2 beds",
     price: 2000,
     type: "Entire place",
     pool: false,
     garage: true
    },
    {
     title: "Awesome Suite",
     price: 230,
     type: "Private Room",
     pool: false,
     garage: false
    },
    {
     title: "Apartment 10' from la Rambla",
     price: 930,
     type: "Entire place",
     pool: true,
     garage: true
    }
   ]

   const poolApartments = places.filter(a=> a.pool);

   console.log(poolApartments)


   