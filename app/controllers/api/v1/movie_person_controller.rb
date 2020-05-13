require 'date'
class Api::V1::MoviePersonController < ApplicationController
  def show 
    api_key = Rails.application.credentials.movie_db[:api_key]
    response = RestClient.get("https://api.themoviedb.org/3/person/#{params[:id]}/movie_credits?api_key=#{api_key}")
    response_body = JSON.parse(response.body)
    reply = serialize_actor(response_body)
    render json: reply[:data], status: reply[:status]
  end

  private

  def serialize_actor(data)
    upcoming = data['cast'].select {|movie| movie['release_date'].to_s > Date.today.prev_month(3).to_s }
    upcoming.map!{ |movie|
      {
        title: movie['title'],
        role: "Actor(#{movie['character']})",
        release_date: movie['release_date'],
        description: movie['overview'],
        image: "https://image.tmdb.org/t/p/w154#{movie['poster_path']}"
      }
    }
    { status: upcoming.length == 0 ? :no_content : :ok, data: { id: data['id'], movies: upcoming }}
  end
end
