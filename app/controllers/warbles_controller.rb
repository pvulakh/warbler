class WarblesController < ApplicationController
  before_action :ensure_logged_in, except: [:index, :show]

  def set_cookie
    maybe_cookie = params[:my_cookie]

    if maybe_cookie
      session[:my_cookie] = maybe_cookie
      render plain: "I am setting your cookie: #{session[:my_cookie]}"
    else
      render plain: "You must provide a cookie"
    end
  end

  def get_cookie
    # // debugger
    my_cookie = session[:my_cookie]
    if my_cookie
      render plain: "Here's your cookie: #{my_cookie}"
    else
      render plain: "You haven't set a cookie called :my_cookie yet"
    end
  end
  
  def index
    # what does index mean?
    # restful route signifying a collection
    # show us all of this particular collection
    # here we use ActiveRecord to pull all the warbles from
    # the db and save it as an instance variable
    @warbles = Warble.all.includes(:author)
    render :index
  end

  # REST and resources
  # REST intends to represent everything in our DB as a resource
  # REST has by convention routes that represent a collection or one particular instance of that collection
  def show 
    @warble = Warble.find_by(id: params[:id])
    # // debugger
    # params is info sent to the server in the request
    # hash-like object available to us in our controllers
    if @warble 
      render :show
    else 
      redirect_to warbles_url
    end
  end

  def new 
    @warble = Warble.new
    render :new
  end

  def edit 
    @warble = Warble.find(params[:id])
    render :edit 
  end

  # what is the difference between new and create?
  # new will render a form 
  # create will perform the work of trying to persist a new instance to the db
  def create
    @warble = current_user.warbles.new(warble_params)
    if @warble.save 
      # render json: @warble 
      redirect_to warble_url(@warble)
      # return 
    else 
      flash.now[:errors] = @warble.errors.full_messages
      render :new 
      # render json: @warble.errors.full_messages, status: 422 
    end 
    # render :new 
  end

  def destroy
    # the current user can only destroy their warble.
    # cant destroy someone elses warble.
    @warble = current_user.warbles.find(params[:id]) 
    @warble.destroy 
    redirect_to warbles_url
    # render json: ["tweet destroyed"]
    # METAPROGRAMMING
    # redirect means to issue an additional request to a separate url
    # the uri will match the route to which we redirect
    # 2 req/res cycles; respond with the instruction to issue another req
  end

  def update
    @warble = current_user.warbles.find(params[:id]) 
    if @warble.update(warble_params)
      redirect_to warble_url(@warble)
    else  
      flash.now[:errors] = @warble.errors.full_messages 
      # flash[:errors] << "helpful message about your error"
      render :edit
      # render json: @warble.errors.full_messages, status: :unprocessable_entity
      # flash is particularly useful for notifications, eg. successful update, errors, etc
      # session is useful for tokens and sensitive information that we want to remain hidden/encrypted
      # cookies are a middleground, we default to using session cookies
    end
  end

  private 
    # Sadly, we cannot assume users will play nicely with our apps
    # STRONG PARAMS - whitelisting certain keys in the params hash that we will allow through
    # rails will throw an error if we try to access params directly when creating a model instance
    def warble_params
      params.require(:warble).permit(:body)
      # permit only columns in your table that you are willing 
      # to let your users to update
    end
end