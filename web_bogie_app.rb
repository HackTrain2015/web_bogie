require 'sinatra/base'
require 'sinatra/assetpack'
require 'faraday'
require 'json'
require 'pry'
require 'httparty'
require File.expand_path(File.dirname(__FILE__) + '/lib/get_train_data')
require File.expand_path(File.dirname(__FILE__) + '/lib/train_view_helpers')



class WebBogieApp < Sinatra::Base
  register Sinatra::AssetPack
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
              '/bower_components/foundation/js/foundation.js'
            ]

    js :application, [
                     '/js/app.js'
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
    binding.pry
    r = results.first
      binding.pry
      # r = r.to_h
      @traindata['next_train'] = r["name"]
      @traindata['station_platform'] = 2
      @traindata['train_arrival_time'] = r["estimated_arrival_time"]
      @traindata['delayed_in_minutes'] =  if r["status"] != 'On time'
      @traindata['train_carriages'] = r["carriages"]
      @traindata['num_carriages'] = r["carriages"].size
      binding.pry
    # Faraday.get("#{request_uri}/")
    erb :index, layout: :layout
  end
end

get '/departures' do
  "Departures"
  erb :departures_all, layout: :layout
end

get '/arrivals' do
  Arrivals
end

get '/departures/:stncode' do
  if params[:stncode]
    deps = departures(params[:stncode])
    carriages = generate_random_carriage_data(deps)
    @traindata = carriages
    # params[:stncode]
    erb :departures, layout: :layout

  end
end

get '/arrivals/:stncode' do
  if params[:stncode]
    arrivs = arrivals(params[:stncode])
    # arrivs.to_s
    # params[:stncode]
    # erb :arrivals, layout: :layout
    carriages = generate_random_carriage_data(arrivs)
    @traindata = carriages
    erb :arrivals, layout: :layout

  end
end

  #get my next train for platform X which is knowqn

  get '/nextrain/:stncode/:platform' do
    nextrain(params[:stncode],params[:platform])
  end


end

