class Api::V1::ArtworksController < ApplicationController

  def initial
    url = 'https://api.thewalters.org/v1/collections/7/objects.json?apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 

  private 

  def api_key
    Rails.application.credentials.walters_api
  end
end