class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  #ログインの前に特定のアクションを実行させるもの　※全ファイルにbefore_actionを適用させると全てのviewファイルがログインしないと入れなくなるので、適宜skip_before_actionを使ってアクションごとにログインしなくても表示できるようにしておく
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end
  
  def guest_check
    if current_user.name == "ゲストユーザー"
       flash[:warning]= "ユーザー登録が必要です"
       redirect_to posts_path
    end
  end

end
