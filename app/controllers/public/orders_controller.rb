class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :thanks, :index, :show]

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
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all

    if @order.save
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.add_tax_price, amount: cart_item.amount, making_status: 0)
        end
      redirect_to orders_thanks_path
      @cart_items.destroy_all
    else
      render 'new'
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(8).order(created_at: :DESC)
  end

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
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
