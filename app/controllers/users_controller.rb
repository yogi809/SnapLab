class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('defaults.message.created', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: User.model_name.human)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
