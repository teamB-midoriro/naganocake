class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  # 小計を求めるメソッド
  def subtotal
    item.add_tax_price * amount
  end
  enum making_status: { impossible_manufacture:0, waiting_manufacture:1, manufacturing:2, finish:3 }
end
