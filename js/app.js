// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

$( window ).load(function() {

	function loadcarriages(colour){

		greencarriages = $('object[class*='+colour+']');
		if (colour === "amber") {
			colour = "yellow";
		};
		console.log(greencarriages);
		for (var i = 0; i <= greencarriages.length - 1; i++) {
			console.log(i);
			console.log(greencarriages[i].contentDocument);
			greencarriages[i].contentDocument.getElementById('indicator-colour').setAttribute('style','fill:'+colour+'');
		};
			

	};
	loadcarriages('red');
	loadcarriages('green');
	loadcarriages('amber');
	
});

