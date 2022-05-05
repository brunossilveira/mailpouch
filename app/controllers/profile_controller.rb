class ProfileController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(user_params)
      byebug
      redirect_to inbox_index_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
