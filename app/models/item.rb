class Item < ApplicationRecord
 # belongs_to genre
  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :item_image
  end
  validates :is_active, inclusion:{in: [true, false]}
  has_one_attached :item_imege
end
