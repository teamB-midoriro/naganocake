class Public::OrdersController < ApplicationController
  # befor_action :athenticate_customer!
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = currnet_customer.find(params[:id])
  end
end
