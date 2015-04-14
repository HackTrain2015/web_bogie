module GetTrainData
	require 'json'
	# require 'httparty'
	# include HTTParty
	RAIL_API_ENDPOINT = 'https://huxley.apphb.com'
	RAIL_API_KEY = "93af89ab-ab40-44f8-9b14-25c622751b2f"
		
	
	def next_train_from_station
		
	end

	def next_train_to_station
		
	end

	def departures(station)
		begin
			prepared_request = "#{RAIL_API_ENDPOINT}/departures/#{station}?accessToken=#{RAIL_API_KEY}"
			departures_from = HTTParty.get(prepared_request)
			JSON.parse(departures_from.body)
		rescue JSON::ParserError => e
			"Could not get HTTP Request"
			
		end
			
				
	end

	def arrivals(station)
		begin
			prepared_request = "#{RAIL_API_ENDPOINT}/arrivals/#{station}?accessToken=#{RAIL_API_KEY}"
			departures_from = HTTParty.get(prepared_request)
			JSON.parse(departures_from.body)
		rescue JSON::ParserError => e
			"Could not get HTTP Request"
			
		end
		
	end

	def generate_random_carriage_data(stationdata)

		# A carriage has, an ID number, total seats, total booked seats, hasluggage, hasbikes
		if stationdata
			stationdata['trainServices'].each do |service|
				service['carriages'] = Array.new()
				rand(3..12).times do |carriage|
					total_seats = rand(25...100)
					free_seats = total_seats-rand(1...total_seats)
					# binding.pry
					has_luggage = rand(0..1)
					has_bikes = rand(0..1)
					service['carriages'].push({"total_seats" => total_seats, "free_seats" => free_seats, "has_luggage" => has_luggage, "has_bikes" => has_bikes})
				end
			end
		end

	end

end