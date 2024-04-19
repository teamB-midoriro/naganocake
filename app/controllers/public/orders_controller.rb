class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :thanks]

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
    @cart_items.each do |cart_item|
      ary << cart_item.item.add_tax_price * cart_item.amount
    end
    @cart_items_price = ary.sum
    @shipping_cost = 800
    @total_payment = @shipping_cost + @cart_items_price
    # hidden_field
    @order_new = Order.new
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.add_tax_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      @order_details.save!
    end

    if CartItem.destroy_all
      redirect_to orders_thanks_path
    else
      render 'new'
    end
  end

  def thanks
  end

  def show
    render 'thanks'
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :customer_id, :status)
  end

  def cartitem_nill
     cart_items = current_customer.cart_items
     if cart_items.blank?

      redirect_to cart_items_path
     end
  end

end