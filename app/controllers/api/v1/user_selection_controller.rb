# frozen_string_literal: true

require 'date'
include GenreTranslator
include PersonIdTranslator

class Api::V1::UserSelectionController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.user_selections.create(person_id: params[:person_id])
  end

  def index
    person_list = current_user.user_selections
    with_names = serialize_response(person_list)
    render json: { user_id: current_user[:id], user_selection: with_names }
  end

  def destroy
    current_user.user_selections.destroy(params[:person_id])
    render json: :index
  end

  private

  def addName(data)
    data.map { |person| person.merge!({ 'name' => PersonIdTranslator.id_to_name(person['person_id']) }) }
  end

  def serialize_response(data)
    data = addName(JSON.parse(data.to_json))
    data.map! do |person|
      {
        id: person['person_id'],
        name: person['name']
      }
    end
  end
end
