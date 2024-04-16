class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
  end

  def create
    cart_item = crrent_customer.cart_items.build(cart_item_params)
    cart_item.item_id =　cart_item_params[:item_id]
    if CartItem.find_by(item_id :params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id :params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:item_id].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item.save
      redirect_to care_itemds_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
