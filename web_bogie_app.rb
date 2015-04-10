require 'sinatra'
require 'sinatra/assetpack'
require 'faraday'

# class WebBogieApp < Sinatra::Base
#   register Sinatra::AssetPack

  assets do
    serve '/js', from: 'js'
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

  get '/test' do
    erb :index
  end


  
# end

# Sinatra::Application.routes["GET"].each do |route|
#   puts route[0]
# end
  #get my next train for platform X which is knowqn
#
#   get '/nextrain/:stncode/:platform' do
#     nextrain(params[:stncode],params[:platform])
#   end
#
#   def nextrain(stationcode='EUS',platform='3')
#     @stationcode = stationcode
#     @platform = platform
#     "#{@stationcode}:  #{@platform}"
#   end
# end
#
# module RailApi
#   class ApiError < StandardError
#   end
#
#   class Get
#     include Faraday
#     def request
#       @request ||= Faraday.get(url)
#     end
#
#   end
# end
#
# class Api
#   def response
#     request.env[:status] == 200 ? request.env[:body] : ApiError.new(request.env[:body])
#   end
# end