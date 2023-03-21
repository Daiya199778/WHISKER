class KonwledgesController < ApplicationController
  skip_before_action :require_login, only: %i[show]
  def show; end

  def history; end

  def whiskeys; end

  def countries; end

  def how_to_drink; end
end
