class Api::V1::ArtworksController < ApplicationController

  def initial
    url = 'https://api.thewalters.org/v1/objects.json?keyword=landscape&classification=painting&medium=oil&pageSize=100&apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 

  def search_by_keyword
    keyword = params['keyword']
    if keyword.include?(' ')
      keyword_arr = keyword.gsub(/\s+/m, ' ').strip.split(" ")
      keyword = keyword_arr[0]
      keyword_arr.shift()
      for x in keyword_arr do
        keyword = keyword + '%20' + x
      end
    end
    url = 'https://api.thewalters.org/v1/objects.json?keyword='+keyword+'&apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end

  def artwork_detail
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