# frozen_string_literal: true

class MoviePersonSerializer < ActiveModel::Serializer
  attributes :id, :movies
  
  def movies
    object.cast.map do |movie|
      {
        title: movie.title,
        role: "Actor(#{movie.character})",
        release_date: movie.release_date,
        description: movie.overview,
        image: "https://image.tmdb.org/t/p/w154#{movie.poster_path}"
      }
    end
  end
end
