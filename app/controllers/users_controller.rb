class UsersController < ApplicationController
  
  def new
    @user = User.new 
    render :new
  end

  def create
    @user = User.new(user_params)
    # we hardcode in location_id as we do not as yet have a dynamic way to assign location
    @user.location_id = Location.first.id
    if @user.save 
      login!(@user)
      redirect_to warbles_url
    else 
      flash.now[:errors] = @user.errors.full_messages
      render :new 
    end
  end

  private 
    def user_params 
      params.require(:user).permit(:name,:password)
    end
end