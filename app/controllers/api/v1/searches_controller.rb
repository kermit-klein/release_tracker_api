class Api::V1::SearchesController < ApplicationController
  def index
    api_key = Rails.application.credentials.movie_db[:api_key]
    begin
      response = RestClient.get("https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=#{params[:q]}&page=1&include_adult=false")
      response_body = JSON.parse(response.body)
      render json: { result: serialize_response(response_body)}

    rescue 
      render json: { result: {errors:["query must be provided"]} }, status: :unprocessable_entity
    end
  end

  private

  def serialize_response(data)
    people = data['results'].select {|result| result['media_type'] === "person"}
    people.map!{ |person|
      { id: person['id'], type: "person", name: person['name'], known_for_role: person['known_for_department'], known_for_movie: person['known_for'][0]['title'] }
    }
  end
end
