class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index,:show, :complete]

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.new(order_params)

    if params[:order][:address_type] == "0"  #自身の住所を選択
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_type] == "1"  #登録済住所から選択
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else params[:order][:address_type] == "2"  #新しい住所を選択
      @order.customer_id = current_customer.id
    end

    # 商品合計額の計算
    ary = []
    @cart_items.each.do |cart_item|
      ary << cart_item.item.price * cart_item.amount

    @cart_items_price = ary.sum
    shipping_fee = 800
    @total_price = shipping_fee + @cart_items_price
  end

  def thanks
  end

  def create
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
