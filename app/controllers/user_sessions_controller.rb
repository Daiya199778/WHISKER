class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new ;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      #ログイン認証に成功したら投稿一覧画面へ遷移するようにする
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
end
