require 'sinatra/activerecord'
class Station < ActiveRecord::Base

	def self.similar(station)
		preparedstation = station
		@stations = Station.where('name LIKE ?',"%#{preparedstation}%").select('name AS  label', 'station_code AS value')
	end
end