class Api::V1::MoviePersonController < ApplicationController
  def show 
    api_key = Rails.application.credentials.movie_db[:api_key]
    response = RestClient.get("https://api.themoviedb.org/3/person/#{params[:id]}/movie_credits?api_key=#{api_key}")
    response_body = JSON.parse(response.body)
    render json: response_body

  end
end
