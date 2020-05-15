require 'json'
module GenreTranslator
  def self.id_to_name(id)
    file = File.read(File.join Rails.root, 'lib', 'cached', 'genre_ids.json')
    data = JSON.parse(file)
    data.find {|genre| genre['id'] == id }['name']
  end

  def self.name_to_id(name)
    file = File.read(File.join Rails.root, 'lib', 'cached', 'genre_ids.json')
    data = JSON.parse(file) 
    data.find {|genre| genre['name'] == name }['id']
  end
end