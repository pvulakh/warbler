class SessionsController < ApplicationController
  def new 
    # a new session form means a login form
    # creating a new session == logging in
    render :new 
  end

  def create
    # TO BE LOGGED IN - USER'S SESSION TOKEN FROM DB MATCHES SESSION COOKIE IN THEIR BROWSER
    # we refrain from using an instance variable for user
    # because don't want to pass the instance of the user to the view
    # // debugger
    user = User.find_by_credentials(params[:user][:name],
                                    params[:user][:password])
    if user 
      # Log us in!
      login!(user) 
      redirect_to warbles_url
    else  
      flash.now[:errors] = ["Invalid Name or Password"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end