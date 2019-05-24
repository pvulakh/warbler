class Api::UsersController < ApplicationController
  def index
    @users = User.all.includes(:location)
    # @locations = Location.all
    # render json: @users 
    render :index #apps view
  end

  def show
    @user = User.find(params[:id])
    # render json: @user 
    render :show
  end 

end 