class Api::V1::SearchesController < ApplicationController
  def index
    api_key = Rails.application.credentials.movie_db[:api_key]
    begin 
      response = RestClient.get("https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=#{params[:q]}&page=1&include_adult=false")
      response_body = JSON.parse(response.body)
      render json: { result: response_body['results'] }
    rescue 
      render json: { result: {errors:["query must be provided"]} }, status: :unprocessable_entity
    end
  end
end
