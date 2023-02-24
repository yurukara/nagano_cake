class CartItem < ApplicationRecord

  belongs_to :member
  belongs_to :item
  
  validates :quantity, numericality: { in: 1..50 }

  def subtotal
  #税込み価格と個数の掛け算です。
    item.with_tax_price.floor*quantity.to_i
  end
  
end
