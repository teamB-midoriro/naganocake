class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = currnet_customer.find(params[:id])
  end
end
