require 'sinatra'
require 'sinatra/assetpack'
require 'faraday'
require 'json'

# class WebBogieApp < Sinatra::Base
#   register Sinatra::AssetPack

  assets do
    serve '/js', from: 'js'
    serve '/files', from: 'files'
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

    js_compression :jsmin
  end

  get '/' do
    json_file = File.read('files/testdata.json')
    # results = JSON.parse(json_file)
    # results.first do |r|
    #   @next_train = r[""]
    #   @station_platform = r[""]
    #   @train_arrival_time = r[""]
    #   @delayed_in_minutes =  if r["status"] != 'On time'
    #   @train_carriages = r[""]
    # end
    # Faraday.get("#{request_uri}/")
    erb :index, layout: :layout
  end

  #get my next train for platform X which is knowqn

  get '/nextrain/:stncode/:platform' do
    nextrain(params[:stncode],params[:platform])
  end

  def nextrain(stationcode='EUS',platform='3')
    @stationcode = stationcode
    @platform = platform
    "#{@stationcode}:  #{@platform}"
  end
# end
