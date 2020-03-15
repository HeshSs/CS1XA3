//import {MDCRipple} from '@material/ripple';

//const buttonRipple = new MDCRipple(document.querySelector('.mdc-button'));
var counter = 0;

function getRandomColor() {
	var letters = '0123456789ABCDEF';
	var color = '#';
	for (var i = 0; i < 6; i++) {
		color += letters[Math.floor(Math.random() * 16)];
	}
	return color;
}

function darkMode() {
	var element = document.body;
	var button = document.getElementById("theme");
	element.classList.toggle("dark-mode");

	if (counter % 2 == 0) {
		$(".resume-wrapper").css("background-color", "#212121");
		$(".resume-wrapper").css("color", "white");
	} else {
		$(".resume-wrapper").css("background-color", "white");
		$(".resume-wrapper").css("color", "black");
	}

	if (button.innerHTML == "Dark Mode") button.innerHTML = "Light Mode";
	else button.innerHTML = "Dark Mode";

	counter++;


}

$(document).ready(function(){
	$(".bar").mousemove(function(){
		$(this).css("background-color", getRandomColor());
	});
});
