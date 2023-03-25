class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :guest_check
  
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('profiles.edit.success')
    else
      flash.now['danger'] = t('profiles.edit.fail')
      render :edit
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache, :introduction)
  end
end
