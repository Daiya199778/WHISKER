class UserSessionsController < ApplicationController
  def new ;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      #投稿ページにアクセスしようとしたユーザにログインを要求する場合、require_loginメソッドでユーザをログインページに誘導し、ログインが成功したら、最初に訪れようとしていた掲示板ページにリダイレクトさせる
      redirect_back_or_to root_path, success: t('.success')
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
