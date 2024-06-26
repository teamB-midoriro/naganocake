class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4 }
  enum payment_method: { credit_card: 0, transfer: 1 }
end
