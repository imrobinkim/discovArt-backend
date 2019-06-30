class Api::V1::ArtworksController < ApplicationController

  def initial
    url = 'https://api.thewalters.org/v1/objects?keyword=landscape&classification=painting&medium=oil&pageSize=100&apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 

  def show
    artwork_id = params[:id]
    url = 'https://api.thewalters.org/v1/objects/'+artwork_id+'.json?apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 

  private 

  def api_key
    Rails.application.credentials.walters_api
  end
end