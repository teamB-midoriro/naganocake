class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = order.page(params[:page]).per(10).order(created_at: :DESC)
  end
end
