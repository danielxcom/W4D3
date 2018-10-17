class UsersController < ApplicationController

  before_action :ensure_not_logged_in

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
