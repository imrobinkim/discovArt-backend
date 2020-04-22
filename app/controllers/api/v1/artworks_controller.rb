class Api::V1::ArtworksController < ApplicationController

  def index
    if params['page']
      page = params['page']
    else 
      page = '1'
    end

    if params['keyword']
      keyword = params['keyword']

      if keyword.include?(' ')
      keyword_arr = keyword.gsub(/\s+/m, ' ').strip.split(" ")
      keyword = keyword_arr[0]
      keyword_arr.shift()
        for x in keyword_arr do
          keyword = keyword + '%20' + x
        end
      end
    else
      keyword = 'watercolor'
    end

    url = 'https://api.harvardartmuseums.org/object?hasimage=1&size=18&keyword='+keyword+'&page='+page+'&apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 
  

  def artwork_detail
    artwork_id = params[:id]
    url = 'https://api.harvardartmuseums.org/object/'+artwork_id+'?apikey='+api_key
    response = RestClient.get(url).body
    render json: response
  end 

  # Add/remove favorite artworks for current_user
  def favorite
    user = User.find(params[:user]["id"]) # Find logged in/current user.

    # Only create new instance of artwork in OUR db if it doesn't exist yet.
    # Otherwise, find artwork instance from within our db.
    artwork = Artwork.exists?(params[:artwork]["id"]) ? Artwork.find(params[:artwork]["id"]) : Artwork.create(artwork_params)
    
    if user.favorites.include?(artwork)
      user.favorites.delete(artwork)
    else
      user.favorites << artwork
    end
  end

  private 

  def api_key
    Rails.application.credentials.harvard_art_musuem_api
  end

  def artwork_params
    params.require(:artwork).permit(:id, :title, :people, :dated, :classification, :primaryimageurl)
  end 
end