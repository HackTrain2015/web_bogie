require 'sinatra/base'
require 'sinatra/assetpack'
require 'faraday'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra/activerecord'
require './models'
require File.expand_path(File.dirname(__FILE__) + '/lib/get_train_data')
require File.expand_path(File.dirname(__FILE__) + '/lib/train_view_helpers')




class WebBogieApp < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::ActiveRecordExtension

  include GetTrainData
  # include HTTParty

  helpers do
    include TrainViewHelpers
  end
  assets do
    serve '/js', from: 'js'
    serve '/files', from: 'files'
    serve '/css', from: 'css'
    serve '/images', from: 'images'    # Default
    serve '/bower_components', from: 'bower_components'

    js :modernizr, [
                   '/bower_components/modernizr/modernizr.js',
                 ]

    js :libs, [
              '/bower_components/jquery/dist/jquery.js',
              '/bower_components/foundation/js/foundation.js',
              '/bower_components/jquery-ui/jquery-ui.js'
            ]

    js :application, [
                     '/js/app.js'
                   ]
    js :departures, [
                '/js/departures.js'
    ]
    js :arrivals, [
                '/js/arrivals.js'
    ]
    css :application, [
          '/css/application.css'
        ]

    js_compression :jsmin
  end

  # get '/' do
  #   "Hello World"
  # end
  get '/' do
    json_file = File.read('files/testdata.json')
    results = JSON.parse(json_file)
    @traindata = {}
    r = results.first
      # r = r.to_h
      @traindata['next_train'] = r["name"]
      @traindata['station_platform'] = 2
      @traindata['train_arrival_time'] = r["estimated_arrival_time"]
      @traindata['delayed_in_minutes'] =  if r["status"] != 'On time'
      @traindata['train_carriages'] = r["carriages"]
      @traindata['num_carriages'] = r["carriages"].size
    # Faraday.get("#{request_uri}/")
    erb :index, layout: :layout
  end
end


get "/station_search" do
  station = params['query']
  @results = Station.similar(station)
  @results.to_json
end

get '/departures' do
  if (params[:stncode] && station_exists?(params[:stncode]))
    @station = getStationData(params[:stncode])
    deps = departures(params[:stncode])
    carriages = generate_random_carriage_data(deps)
    @traindata = carriages
    erb :departures, layout: :layout
  else
    erb :departures_all, layout: :layout
  end

end

get '/arrivals' do
  if (params[:stncode] && station_exists?(params[:stncode]))
    @station = getStationData(params[:stncode]).first
    arrivs = arrivals(params[:stncode])
    carriages = generate_random_carriage_data(arrivs)
    @traindata = carriages
    erb :arrivals, layout: :layout  
  else
    erb :arrivals_all, layout: :layout
  end

end

get '/departures/:stncode' do
  if (params[:stncode] && station_exists?(params[:stncode]))
    @station = getStationData(params[:stncode]).first
    deps = departures(params[:stncode])
    carriages = generate_random_carriage_data(deps)
    @traindata = carriages
    erb :departures, layout: :layout
  else
    erb :departures_all, layout: :layout
  end
end

get '/arrivals/:stncode' do
  if (params[:stncode] && station_exists?(params[:stncode]))
    @station = getStationData(params[:stncode]).first
    arrivs = arrivals(params[:stncode])
    carriages = generate_random_carriage_data(arrivs)
    @traindata = carriages
    erb :arrivals, layout: :layout  
  else
    erb :arrivals_all, layout: :layout
  end
end

  #get my next train for platform X which is knowqn

  get '/nextrain/:stncode/:platform' do
    nextrain(params[:stncode],params[:platform])
  end


end

