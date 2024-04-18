class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :item_image
  end
  validates :is_active, inclusion:{in: [true, false]}
  has_one_attached :item_image
  validates :amount, presence: true
  #消費税を求めるメソッド
  def add_tax_price
    (self.price * 1.1).round
  end
end
