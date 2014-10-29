class UsersController < ApplicationController
 before_action :redirect_back_to_cats_if_signed_in, only: [:new] 
  # def index
  #   @users = User.all
  #   render :index
  # end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session_token = Session.generate_session_token
      Session.create(user_id: @user.id, session_token: session_token, request_ip: request.ip)
      session[:session_token] = session_token
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
