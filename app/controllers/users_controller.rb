class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :authenticate_user!

  def edit
  end

  def update
    if @user.update(update_params)
      redirect_to new_user_session_path, notice: "Successfully updated your password. Login to continue"
    else
      render :edit
    end
  end

  private
    def update_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def set_user
      @user = current_user
    end
end
