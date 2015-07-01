$(function(){
	// select the searh box with id and attach an autocomplete object to it
	console.log('this is loading');
	searchbox = $('#searchbox');
			searchbox.autocomplete({
				source: function (request,response) {
					console.log('autocompleting');

					jQuery.get
					(
						"http://localhost:9393/station_search", 
						{query : request.term}, 
						function(data, textStatus, xhr) {
					  		//optional stuff to do after success
					  		console.log(jQuery.type(data));
					  		console.log("response!!");
					  		console.log(data);
					  		console.log(textStatus);
					  		console.log(xhr);
					  		response(data);
						},
						"json"
					);
					
				},
				minLength: 2,
			});

			var options = searchbox.autocomplete("option");
			console.log(options);



});

function getInputValue () {
	// body...
	console.log($('#searchbox').val());
	var url = '/departures/'+ $('#searchbox').val();
	window.location = url;
}

