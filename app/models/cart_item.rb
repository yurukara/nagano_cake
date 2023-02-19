class CartItem < ApplicationRecord

  belongs_to :member
  belongs_to :item

  def subtotal
  #税込み価格と個数の掛け算です。
    item.with_tax_price.floor*quantity.to_i
  end
  
end
