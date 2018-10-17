class SessionsController < ApplicationController

  before_action :ensure_not_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      login_user!(user)
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      flash[:errors] = ['Invalid username or password']
      redirect_to new_session_url
    end
  end

  def destroy
    logout_user!
  end
end
