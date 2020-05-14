require 'date'
class Api::V1::MoviePersonController < ApplicationController
  include GenreTranslator
  def show
    begin
      api_key = Rails.application.credentials.movie_db[:api_key]
      response = RestClient.get("https://api.themoviedb.org/3/person/#{params[:id]}/movie_credits?api_key=#{api_key}")
      response_body = JSON.parse(response.body)
      reply = serialize_person(response_body)
    rescue => exception
      reply = { data: exception.message || "Something went wrong", status: exception.message.to_i || 500}
    end
    render json: reply[:data], status: reply[:status]
  end

  private

  def serialize_person(data)
    cast = data['cast'] || []
    crew = data['crew'] || []
    genre = id_to_name(18)
    binding.pry
    upcoming_cast = cast.select {|movie| movie['release_date'].to_s > Date.today.prev_month(3).to_s }
    upcoming_crew = crew.select {|movie| (movie['release_date'].to_s > Date.today.prev_month(3).to_s) && (movie['job'] === 'Director') }
    upcoming = upcoming_cast.concat(upcoming_crew)
    upcoming.map!{ |movie|
      {
        title: movie['title'],
        role: movie['character'] ? "Actor(#{movie['character']})" : 'Director',
        release_date: movie['release_date'],
        description: movie['overview'],
        image: "https://image.tmdb.org/t/p/w154#{movie['poster_path']}"
      }
    }
    { status: upcoming.length == 0 ? :no_content : :ok, data: { id: data['id'], movies: upcoming }}
  end
end
