module GetTrainData
	include HTTParty
	require 'json'

	
	def next_train_from_station
		
	end

	def next_train_to_station
		
	end

	def departures(station)
		RAIL_API_ENDPOINT = 'https://huxley.apphb.com'
		RAIL_API_KEY = "93af89ab-ab40-44f8-9b14-25c622751b2f"
		begin
			prepared_request = "#{RAIL_API_ENDPOINT}/departures/#{station}/accessToken=#{RAIL_API_KEY}"
			binding.pry
			departures_from = HTTParty.get(prepared_request)
		rescue => e
			"Could not get HTTP Request"
			
		end
			
		JSON.parse(departures_from)		
	end


end