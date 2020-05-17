# frozen_string_literal: true

require 'json'
module PersonIdTranslator
  def self.id_to_name(id)
    file = File.read(File.join(Rails.root, 'lib', 'cached', 'person_ids.json'))
    data = JSON.parse(file)
    data.find { |person| person['id'] == id }['name']
  end

  def self.name_to_id(name)
    file = File.read(File.join(Rails.root, 'lib', 'cached', 'person_ids.json'))
    data = JSON.parse(file)
    data.find { |person| person['name'] == name }['id']
  end
end
