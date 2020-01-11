//Declare Variable for hacker1
var hacker1 = "Mayank";

//Declare variable for hacker2
var hacker2;

//Prompt to ask user for navigator's name
hacker2 = window.prompt("Enter Navigator's Name:")

//Print the navigator's name
console.log(`The navigator's name is  ${hacker2}`);

//Conditionals
//Compare the length of names for driver and navigator and print accordingly
function EqualLen(hacker1,hacker2) {
  if (hacker1.length === hacker2.length)
  console.log (`wow, you both got equally long names, it has ${hacker1.length} characters!!`);
  if (hacker1.length < hacker2.length)
  console.log (`Yo, navigator got the longest name, it has ${hacker2.length} characters`);
  if (hacker1.length > hacker2.length)
  console.log (`The Driver has the longest name it has ${hacker1.length} characters`);
};

EqualLen(hacker1, hacker2);

//Loops

//Print in reverse order
function reversestring(hacker2){
  var reversedstr = "";
  for (var i = hacker2.length-1; i>=0; i--) {
    reversedstr = reversedstr + hacker2[i]
  }; 
  console.log (reversedstr);
};

reversestring(hacker2);



function upperspace (hacker1){
  let emptyString = ""
  for (let i=0; i <hacker1.length; i++) {
    emptyString += hacker1[i].toUpperCase()+' '
    };
    console.log(`Driver's name is Uppercase: ${emptyString}`); 

  };

upperspace(hacker1);


//Lexicographical Order
function lexico(hacker1, hacker2){
  b =   hacker1.localeCompare(hacker2);
  if (b == 0 ) {
    return "What?! You both got the same name?";
  };
  if (b==1) {
    return "Yo, the navigator goes first definitely";
  };
  if (b==-1){
    return "The driver's name goes first"
  };
};

console.log(lexico(hacker1,hacker2));


//
var loremipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut viverra sem eu massa vestibulum aliquam. Curabitur aliquam vitae arcu nec tristique. Sed lacinia, metus at tincidunt venenatis, magna nulla gravida neque, id finibus dolor nisl non eros. Vestibulum ut lacus scelerisque, rhoncus tellus id, auctor arcu. Maecenas sit amet felis a magna molestie pulvinar sed at massa. Aenean gravida id magna eu hendrerit. Phasellus molestie massa enim, ac interdum urna ultrices in.Fusce a sem interdum libero feugiat scelerisque. Proin nunc magna, malesuada sit amet pellentesque molestie, tempus ut enim. Integer tristique, erat non lacinia lobortis, orci quam dictum lorem, at iaculis augue tortor vehicula quam. Donec lacinia ligula leo, nec tempor massa varius id. Sed maximus mi eu sagittis iaculis. Integer sed commodo enim. Aliquam pellentesque sollicitudin dolor, sit amet interdum nisi porta ut. Donec ex magna, pellentesque nec commodo id, placerat in diam. Sed sit amet ultricies ex. Curabitur dignissim lorem non consequat blandit. Sed ac condimentum tortor. Curabitur tincidunt sit amet eros vitae gravida. Donec placerat gravida mattis. Curabitur sed est finibus, rutrum lectus at, malesuada orci. Integer viverra mauris porta, interdum lorem vel, ultricies dolor. Nulla ac sollicitudin felis.Etiam luctus varius mi, quis ornare augue efficitur quis. Aenean id porttitor turpis. Nam convallis leo quis tellus eleifend, dapibus congue neque hendrerit. Aliquam posuere blandit lacus id molestie. Praesent a tellus quis erat aliquam elementum. Donec ac dui nunc. Mauris velit neque, consequat id venenatis ac, interdum at tellus. In facilisis arcu quam, eu consequat dui aliquet et. Curabitur dictum ex a odio suscipit, vitae semper lectus laoreet. Nullam nunc velit, viverra nec ultrices quis, cursus sit amet tortor. Quisque in auctor ante mayankAsmi.";

function countlen(string){
  totwords = 0;
  for (i =0; i<string.length; i++ ){
    if (string[i] == " "){
      totwords += 1;
    }
  }
  console.log(totwords);
};

  countlen(loremipsum);


//Palindrome
function Palindrome(word){
    var reversedstr = "";
    for (var i = word.length-1; i>=0; i--) {
      reversedstr = reversedstr + word[i]
    }; 
    console.log (reversedstr);
    if (reversedstr == word ) {
      return "It is a Palindrome"
    }
    else {
      return "No, It's not a Palindrome"
    }
  };


  console.log(Palindrome("lepel"));
