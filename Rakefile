APP_FILE  = 'web_bogie_app.rb'
APP_CLASS = 'Sinatra::Application'

require 'sinatra/assetpack/rake'
require 'sinatra/activerecord/rake'
require 'sinatra/activerecord'
require 'pry'

namespace :db do
  task :load_config do
    require "./web_bogie_app"
  end
end

namespace :stations do
	desc "Load all stations from a given file"
	task :load_stations do
		require 'json'
		load 'models.rb'
		stations = JSON.parse(File.read('public/stationcodes.json'))
		binding.pry
		stations.each do |station|
			Station.create({name: station['label'], station_code: station['value']})
		end
	end
end