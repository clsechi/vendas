class HomeController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :show]
  def index() end

  def show() end
end
