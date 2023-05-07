class UserSessionsController < ApplicationController
  #ユーザー登録画面にてnewアクションとcreateアクションはログインしなくても使えるようにskip_before_action
  skip_before_action :require_login, only: %i[new create destory guest_login]
  def new ;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to posts_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end

  def guest_login
    @guest_user = User.new(
      name: 'ゲストユーザー',
      email: 'guestuser.whisker@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    unless @guest_user.save
      @guest_user = User.find_by(
      email: 'guestuser.whisker@example.com'
      )
    end
    auto_login(@guest_user)
    redirect_to posts_path(@guest_user), success: 'ゲストとしてログインしました'
  end

end
