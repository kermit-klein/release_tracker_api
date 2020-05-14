class Api::V1::SearchesController < ApplicationController
  def index
    api_key = Rails.application.credentials.movie_db[:api_key]
    if params[:q] == ""
      response = RestClient.get("https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&page=1&include_adult=false")
      response_body = JSON.parse(response.body)
      render json: { result: response_body }
    else
      response = RestClient.get("https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=#{params[:q]}&page=1&include_adult=false")
      response_body = JSON.parse(response.body)
      render json: { result: response_body['results'] }
    end
  end
end
