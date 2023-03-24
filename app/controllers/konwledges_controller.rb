class KonwledgesController < ApplicationController
  skip_before_action :require_login, only: %i[show history whiskey country how_to_drink]
  def show; end

  def history; end

  def whiskey; end

  def country; end

  def how_to_drink; end
end
