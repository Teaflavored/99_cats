class SessionsController < ApplicationController
  before_action :redirect_back_to_cats_if_signed_in, only: [:new]
  before_action :ensure_user_signed_in, only: [:index]

  def new
    render :new
  end
  
  def index
    @sessions = current_user.sessions
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]    
    )
    
    if @user.nil?
      flash.now[:errors] = ["Invalid sign in."]
      render :new
    else
      session_token = Session.generate_session_token
      Session.create(user_id: @user.id, session_token: session_token, request_ip: request.location.country)
      session[:session_token] = session_token
      redirect_to cats_url
    end
  end
  
  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    if current_user.nil?
      redirect_to new_session_url
    else
      redirect_to sessions_url
    end
  end

  def ensure_user_signed_in
    redirect_to new_session_url if current_user.nil?
  end
end
