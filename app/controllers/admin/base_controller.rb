class Admin::BaseController < ApplicationController
  before_action :check_admin
  #管理者画面は、一般ユーザーと画面のデザインが違うので一般ユーザーとは違うレイアウトファイルを使用するため、下記のように記載する。
  layout 'admin/layouts/application'

  private

  #ログインしてないときに実行される（sorceryメソッド）
  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to admin_login_path
  end

  #管理者権限がないユーザーを排除する目的で設定
  def check_admin
    flash[:warning] = t('defaults.message.not_authorized'), unless current_user.admin?
    redirect_to root_path
  end
end
