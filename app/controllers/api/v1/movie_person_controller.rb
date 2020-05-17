require 'date'
class Api::V1::MoviePersonController < ApplicationController
  include GenreTranslator
  include PersonIdTranslator

  before_action :authenticate_user!, only: [:index]
  def index
    ids = current_user.user_selections.map{|selection| selection[:person_id]}
    begin
      credits = ids.map{|id|
        begin
          get_person_data(id)
        rescue => exception
          { "cast" => [], "crew" => [], "id" => 7 }
        end
      }
      credits_with_name = credits.map{|credit| prepare_for_combine(credit)}
      flat_movie_arr = credits_with_name.flatten
      reply = combine_multiple(flat_movie_arr)
    rescue => exception
      reply = []
    end

    if reply.length == 0
      data = { data: { movies: reply }, error: ids.length == 0 ? "You are not tracking anything" : "No upcoming releases"}
      code = :bad_request
    else
      data = { data: { movies: reply }}
      code = :ok
    end

    render json: data, status: code
  end

  def show
    begin
      response_body = get_person_data(params[:id])
      reply = serialize_person(response_body)
      
    rescue => exception
      reply = { data: exception.message || "Something went wrong", status: exception.message.to_i || 500}
    end
    render json: reply[:data], status: reply[:status]
  end

  private

  def filter_out_old(data)
    cast = data['cast'] || []
    crew = data['crew'] || []
    upcoming_cast = cast.select {|movie| movie['release_date'].to_s > Date.today.prev_month(3).to_s }
    upcoming_crew = crew.select {|movie| (movie['release_date'].to_s > Date.today.prev_month(3).to_s) && (movie['job'] === 'Director') }
    upcoming = upcoming_cast + upcoming_crew
    upcoming
  end

  def combine_multiple(data)
    titles = data.map{|movie| movie[:title]}.uniq
    reply = titles.map{ |title| 
      current_movie = data.find { |movie| movie[:title] == title }
      matches = data.select { |movie| movie[:title] == title }
      {
        title: current_movie[:title],
        role: matches.map{|movie| movie[:role]}.uniq.join(", "),
        release_date: current_movie[:release_date],
        description: current_movie[:overview],
        image: "https://image.tmdb.org/t/p/w154#{current_movie[:poster_path]}",
        genres: current_movie[:genres],
        name: matches.map{|movie| movie[:name]}.uniq.join(", ")
      }
    }
    reply
  end

  def prepare_for_combine(data)
    name = PersonIdTranslator.id_to_name(data['id'])
    upcoming = filter_out_old(data)
    upcoming.map!{ |movie|
      genres = movie['genre_ids'].map{|genre| GenreTranslator.id_to_name(genre)}
      {
        title: movie['title'],
        role: movie['character'] ? "Actor" : 'Director',
        release_date: movie['release_date'],
        description: movie['overview'],
        image: "https://image.tmdb.org/t/p/w154#{movie['poster_path']}",
        genres: genres,
        name: name
      }
    }
  end

  def serialize_person(data)
    upcoming = filter_out_old(data)
    upcoming.map!{ |movie|
      genres = movie['genre_ids'].map{|genre| GenreTranslator.id_to_name(genre)}
      {
        title: movie['title'],
        role: movie['character'] ? "Actor(#{movie['character']})" : 'Director',
        release_date: movie['release_date'],
        description: movie['overview'],
        image: "https://image.tmdb.org/t/p/w154#{movie['poster_path']}",
        genres: genres
      }
    }
    
    if (params.has_key?('genres') && upcoming.length != 0)
      upcoming.select! {|movie| (movie[:genres] & params[:genres]).length != 0 }
    end
    { status: upcoming.length == 0 ? :no_content : :ok, data: { id: data['id'], movies: upcoming }}
  end

  def get_person_data(id)
    api_key = Rails.application.credentials.movie_db[:api_key]
    response = RestClient.get("https://api.themoviedb.org/3/person/#{id}/movie_credits?api_key=#{api_key}")
    response_body = JSON.parse(response.body)
    response_body
  end
end
