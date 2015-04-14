$(function(){
	// select the searh box with id and attach an autocomplete object to it

	searchbox = $('#searchbox');

	searchbox.autocomplete({
		source: "stationcodes.json",
	});

	var options = searchbox.autocomplete("option");
	console.log(options);
});