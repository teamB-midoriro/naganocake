class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(8).order(created_at: :DESC)
  end

  def show
    @order = current_customer.find(params[:id])
    @order_details = current_customer.order_details.all.page(params[:page]).per(8).order(created_at: :DESC)
  end
end
