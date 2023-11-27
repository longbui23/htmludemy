//Image1
var randomNumber1 = Math.floor(Math.random() * 6) + 1;

var randomDiceImage1 = "dice" + randomNumber1 + ".png"

var randomImageSource1 = "images/" + randomDiceImage1; //image 1 - 6

var image1 = document.querySelectorAll("img")[0];

image1.setAttribute("src", randomImageSource1);


//Image 2

var randomNumber2 = Math.floor(Math.random() * 6) + 1;

var randomDiceImage2 = "dice" + randomNumber2 + ".png"

var randomImageSource2 = "images/" + randomDiceImage2; //image 1 - 6

var image2 = document.querySelectorAll("img")[1];

image2.setAttribute("src", randomImageSource2);


//Winning condition
if (randomNumber1 > randomNumber2) {
    document.querySelector("h1").innerHTML = "Player1 Wins!";
}
else if (randomNumber1 < randomNumber2) {
    document.querySelector("h1").innerHTML = "Player2 Wins!";
}
else {
    document.querySelector("h1").innerHTML = "Draw!";
}