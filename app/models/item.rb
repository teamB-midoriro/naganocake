class Item < ApplicationRecord
  has_many :genres
  has_many :cart_items, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :item_image
  end
  validates :is_active, inclusion:{in: [true, false]}
  has_one_attached :item_image
  
  def with_tax_price
    (price * 1.1).floor
  end
  
  def subtotal
    item.with_tax_price * amount
  end
end
