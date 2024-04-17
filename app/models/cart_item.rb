class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def unit_price_with_tax
    price * 1.1
  end
  
  def subtotal
   item.unit_price_with_tax * amount
  end
end
