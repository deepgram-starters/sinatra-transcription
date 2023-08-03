require 'json'
require 'sinatra'
require 'sinatra/cross_origin'
require 'net/http'
require 'uri'
require 'dotenv/load'

class MyApp < Sinatra::Base

  # Serve static files
  set :public_folder, File.dirname(__FILE__) + '/static'
  set :static_url, '/'

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  DEEPGRAM_API_KEY = ENV['deepgram_api_key']
  DEEPGRAM_API_URL = 'https://api.deepgram.com/v1/listen'
  
  # Endpoint
  post '/api' do
    model = params[:model]
    tier = params[:tier]
    features = params[:features]
    url = params[:url]
    
    headers = {
      'Authorization' => "Token #{DEEPGRAM_API_KEY}",
    }

    request_data = {
      model: model,
    }

    JSON.parse(features).each do |key, value|
      request_data[key.to_sym] = value
    end

    # Check if using a file stream or a remote file
    if params[:file] && params[:file][:tempfile]
      file = params[:file][:tempfile]
      headers['Content-Type'] = 'audio/wav'
      audio_data = file.read
    elsif params[:url]
      headers['Content-Type'] = 'application/json'
    end

    # Build out the api url with params
    uri = URI.parse(DEEPGRAM_API_URL)
    uri.query = URI.encode_www_form(request_data)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    # Make the POST request to the Deepgram API
    request = Net::HTTP::Post.new(uri.request_uri, headers)

    if params[:file] && params[:file][:tempfile]
      request.body = audio_data if audio_data
    elsif params[:url]
      request.body = JSON.dump({
        url: url
      })
    end

    # Send the POST request to Deepgram
    response = http.request(request)

    # Handle the response
    response_data = JSON.parse(response.body)

    # Respond with a JSON message indicating success and the API response
    status 200
    { message: 'POST request received successfully.', transcription: response_data }.to_json
    
  end
end

  MyApp.run! port: 8080 if __FILE__ == $0