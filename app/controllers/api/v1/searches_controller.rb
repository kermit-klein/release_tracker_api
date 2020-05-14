require 'date'

class Api::V1::SearchesController < ApplicationController
  def index
    api_key = Rails.application.credentials.movie_db[:api_key]
    begin
      response = RestClient.get("https://api.themoviedb.org/3/search/multi?api_key=#{api_key}&language=en-US&query=#{params[:q]}&page=1&include_adult=false")
      response_body = JSON.parse(response.body)
      render json: serialize_response(response_body)
    rescue 
      render json: { data: {errors:["query must be provided"]} }, status: :unprocessable_entity
    end
  end

  private

  def serialize_response(data)
    people = data['results'].select {|result| result['media_type'] === "person"}
    people.map! { |person|
      { id: person['id'], type: "person", name: person['name'], known_for_role: person['known_for_department'], known_for_movie: person['known_for'][0]['title'] }
    }
    movies = data['results'].select {|result| result['media_type'] === "movie" && result['release_date'].to_s > Date.today.prev_month(3).to_s}
    movies.map! { |movie|
      { id: movie['id'], type: "movie", title: movie['title'], overview: movie['overview'], release_date: movie['release_date'] }
    }
    resp = { status: data['results'].empty? ? :no_content : :ok, data: { people: people, movies: movies } }
  end
end
