# frozen_string_literal: true

require 'json'
module PersonIdTranslator
  def self.id_to_name(id)
    file = File.read(File.join(Rails.root, 'lib', 'cached', 'person_ids.json'))
    data = JSON.parse(file)
    name = data.find { |person| person['id'] == id } || { 'name' => get_name_from_db(id) }
    name['name']
  end

  def self.name_to_id(name)
    file = File.read(File.join(Rails.root, 'lib', 'cached', 'person_ids.json'))
    data = JSON.parse(file)
    data.find { |person| person['name'] == name }['id']
  end

  def get_name_from_db(id)
    api_key = Rails.application.credentials.movie_db[:api_key]
    person = JSON.parse(RestClient.get("https://api.themoviedb.org/3/person/#{id}?api_key=#{api_key}"))
    person ? person['name'] : 'Error'
  end
end
