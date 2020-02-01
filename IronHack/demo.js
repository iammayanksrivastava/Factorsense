function eatDinner(a){
    console.log("Eating Dinner");
    a();

};


function eatDesserts(){
    console.log("Eating Dessert")

};


eatDinner(eatDesserts);