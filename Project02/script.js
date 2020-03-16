var counter = 0;

// Random Color Generator
function getRandomColor() {
	var letters = '0123456789ABCDEF';
	var color = '#';
	for (var i = 0; i < 6; i++) {
		color += letters[Math.floor(Math.random() * 16)];
	}
	return color;
}

// Dark Mode
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

// Change bar color
$(document).ready(function(){
	$(".bar").mouseover(function(){
		$(this).css("background-color", getRandomColor());
	});
	
});

