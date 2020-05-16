require 'date'
class Api::V1::UserSelectionController < ApplicationController

  before_action :authenticate_user!

  def create
    create_new_selection = UserSelection.create(user_id: params[:user], data: params[:movie])
    # binding.pry
    render json: { message: "Data was saved sucessfully", data: create_new_selection }
  end

  def index
    # collection = current_user.user_selection
    render json: { data: current_user }
  end

end