class Api::WarblesController < ApplicationController

  def index
    @warbles = Warble.all
    render json: @warbles
  end

  def show
    # debugger
    @warble = Warble.find(params[:id])

    # debugger
    render :show
  end

  def create
    # debugger
    @warble = Warble.new(warble_params)
    @warble.author = User.first
    if @warble.save
      render json: @warble 
    else 
      render json: @warble.errors.full_messages, status: 422
    end
  end

  private
    def warble_params
      params.require(:warble).permit(:body)
    end 

end