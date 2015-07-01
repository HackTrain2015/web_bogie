module TrainViewHelpers
	def generate_carriage_view(carriages)
	  base_string ="<ul class=\"carriage_list\">"
	  if carriages
	      carriages.each do |carriage|
	        base_string = base_string +"<li class=\"#{generate_classes(carriage)}\"></li>\n"
	      end
	  end
	  base_string = base_string+"</ul>"
	end

	def generate_classes(carriage)
	  classes = ["carriage"]
	  if carriage['free_seats'].to_f / carriage['total_seats'].to_f >= 0.75
	    classes.push('green')
	  elsif ((carriage['free_seats'].to_f)/(carriage['total_seats'].to_f)).between?(0.25,0.75) 
	    classes.push('amber')
	  elsif (carriage['free_seats'].to_f)/(carriage['total_seats'].to_f) <= 0.25
	    classes.push('red')
	  else
	    classes.push('white')
	  end
	  if carriage['has_bikes'] == 1
	    classes.push('bike')
	  end
	  if carriage['has_luggage'] == 1
	    classes.push('luggage')
	  end
	  # binding.pry
	  classes.join(" ")
	end

	def generate_svg_train_view(carriages)
	  #push the first carriage and last carriage as end-left and end-right images, the others just have a class of carriage. 
	  base_string = "<ul class=\"carriage_svg_list\">"
	  if carriages
	    # binding.pry
	    base_string = base_string + "<li class=\"svgcarriage\">#{generate_first_carriage(carriages.first)}</li>"
	    carriages[1..-2].each do |carriage|
	              base_string = base_string + "<li class=\"svgcarriage\">#{generate_svg_carriage(carriage)}</li>"
	    end
	    base_string = base_string + "<li class=\"svgcarriage\">#{generate_last_carriage(carriages.last)}</li>"
	    base_string = base_string+"</ul>"  
	  end
	end

	def generate_first_carriage(carriage)
	  svgclass = generate_classes(carriage)+" train-first"
	  # binding.pry
	  "<object type=\"image/svg+xml\" data=\"/img/train-left-layered.svg\" class=\"#{svgclass}\" >Your browser does not support SVG</object>"
	end

	def generate_last_carriage(carriage)
		svgclass =  generate_classes(carriage)+" train-last"
	  "<object type=\"image/svg+xml\" data=\"/img/train-right-layered.svg\" class=\"#{svgclass}\" >Your browser does not support SVG</object>"      
	end

	def generate_svg_carriage(carriage)
		svgclass = generate_classes(carriage)+" train-carriage"
	  "<object type=\"image/svg+xml\" data=\"/img/train-carriage-layered.svg\" class=\"#{svgclass}\" >Your browser does not support SVG</object>"
	end

	def generate_bike_data(carriage)
		if carriage['has_bikes'] == 0 
			"<img src=\"img/bike.png\" class=\"img-responsive bike\" alt=\"Image\">"
		end
	end

	def generatae_luggage_data(carriage)
		if carriage['has_luggage'] == 0
			"<img src=\"img/luggage.png\" class=\"img-responsive bike\" alt=\"Image\">"
		end			
	end
end