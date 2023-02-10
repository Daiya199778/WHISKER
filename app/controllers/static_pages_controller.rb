class StaticPagesController < ApplicationController
  #ホーム画面にてtopアクションはログインしなくても使えるようにskip_before_action
  skip_before_action :require_login, only: %i[top]
  def top; end
end
