require 'date'
include GenreTranslator

class Api::V1::UserSelectionController < ApplicationController

  # before_action :authenticate_user!

  def create
    create_new_selection = UserSelection.create(user_id: params[:user], person_id: params[:person_id])
    render json: { message: "Data was saved sucessfully", data: create_new_selection }
  end

  def index
    itemAll = []
    personAll = []
    UserSelection.where(user_id: params[:user_id]).map do |item|
      itemAll << item.id
    end
    
    itemAll.map do |item|
      personAll << getTrackedPerson(item)
    end
    render json: { data: personAll }
  end
  
  def getTrackedPerson(person_id)
    
    begin
      api_key = Rails.application.credentials.movie_db[:api_key]
      response = RestClient.get("https://api.themoviedb.org/3/person/#{person_id}/movie_credits?api_key=#{api_key}")
      reply = serialize_person(JSON.parse(response.body))
    rescue => exception
      reply = { data: exception.message || "Something went wrong", status: exception.message.to_i || 500}
    end
    reply
  end

  private

  def serialize_person(data)
    cast = data['cast'] || []
    crew = data['crew'] || []
    upcoming_cast = cast.select {|movie| movie['release_date'].to_s > Date.today.prev_month(3).to_s }
    upcoming_crew = crew.select {|movie| (movie['release_date'].to_s > Date.today.prev_month(3).to_s) && (movie['job'] === 'Director') }
    upcoming = upcoming_cast.concat(upcoming_crew)
    upcoming.map!{ |movie|
      genres = movie['genre_ids'].map{|genre| GenreTranslator.id_to_name(genre)}
      {
        name: movie['name'],
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
end