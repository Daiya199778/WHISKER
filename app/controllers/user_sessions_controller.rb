class UserSessionsController < ApplicationController
  def new ;end

  def create
    @user = login(params[:email], params[:password])
    if @user
      #投稿ページにアクセスしようとしたユーザにログインを要求する場合、
      #require_loginメソッドでユーザをログインページに誘導し、ログインが成功したら、最初に訪れようとしていた掲示板ページにリダイレクトさせる
      redirect_back_or_to root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
