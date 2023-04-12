class OauthsController < ApplicationController
  require "googleauth/id_tokens/errors"
  require 'googleauth/id_tokens/verifier'
  skip_before_action :require_login
  protect_from_forgery except: :callback
  # before_action :verify_g_csrf_token, only: :callback

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if auth_params[:denied].present? || auth_params[:error] == 'ACCESS_DENIED'
      redirect_to login_path, warning: 'ログインをキャンセルしました'
      return
    end

    begin
      create_user_from(provider) unless (@user = login_from(provider))
      redirect_to posts_path(@post), success: "#{provider.titleize}アカウントでログインしました"
    rescue StandardError
      redirect_to login_path, danger: "#{provider.titleize}アカウントでのログインに失敗しました"
    end
  end

  # def callback
  #   if params[:credential].present?
  #     payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: ENV['GOOGLE_CLIENT_ID'])
  #     user = User.find_or_initialize_by(email: payload['email'], login_type: :google)

  #     if user.save
  #       auto_login(user)
  #       redirect_to posts_path, success: t('.success')
  #     else
  #       redirect_to login_path, error: t('.fail')
  #     end

  #   else
  #     redirect_to login_path, error: t('.fail')
  #   end
  # end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :error, :state)
  end

  def create_user_from(provider)
    @user = create_from(provider)
    # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
    reset_session # protect from session fixation attack
    auto_login(@user)
  end

  # def verify_g_csrf_token
  #   if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
  #     redirect_to login_path, error: t('.fail')
  #   end
  # end

end
