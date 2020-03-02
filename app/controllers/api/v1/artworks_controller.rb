class Api::V1::ArtworksController < ApplicationController

  def initial
    
    if params['page']
      page = params['page']
    else 
      page = '1'
    end
      
    url = 'https://api.harvardartmuseums.org/object?keyword=watercolor&size=18&page'+page+'&apikey='+api_key
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
    url = 'https://api.harvardartmuseums.org/object?hasimage=1&size=18&keyword='+keyword+'&apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end

  def artwork_detail
    artwork_id = params[:id]
    url = 'https://api.harvardartmuseums.org/object/'+artwork_id+'?apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 

  private 

  def api_key
    Rails.application.credentials.harvard_art_musuem_api
  end
end