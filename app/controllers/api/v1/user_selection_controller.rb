require 'date'
include GenreTranslator
include PersonIdTranslator

class Api::V1::UserSelectionController < ApplicationController

  before_action :authenticate_user!

  def create
    current_user.user_selections.create(person_id: params[:person_id])
    render json: :index
  end

  def index
    person_list = current_user.user_selections # = [ 6,5,3,1,76,8 ]
    with_names = serialize_response(person_list)
    render json: { user_id: current_user.id, user_selection: with_names}
  end

  def destroy
    current_user.user_selections.destroy(params[:person_id])
    render json: :index
  end

  private

  def addName(data)
    data.map {|person| person.merge!({name: PersonIdTranslator.id_to_name(person.id)}) }
  end

  def serialize_response(data)
    data = addName(JSON.parse(data.to_json))
    data.map!{|person|
      {
        id: person['id'],
        name: person['name']
      }
    }
  end
end