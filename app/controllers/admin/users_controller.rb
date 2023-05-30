class Admin::UsersController < Admin::BaseController
  before_action :set_user, only:[:show, :edit, :update, :destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, success: t('admin.users.update.success')
    else
      flash.now['danger'] = t('admin.users.update.fail')
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('admin.users.destroy.success')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache, :introduction, :role)
  end

end
