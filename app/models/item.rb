class Item < ApplicationRecord

  has_many :cart_items
  has_many :order_items
  has_one_attached :image
  
  with_options presence: true do
   validates :name
   validates :introduction
   validates :price
   validates :is_active
   validates :image
 end


#商品単価の3桁ごとに「,」を入れるメソッドです(山田)
  def number_to_currency(price)
    "¥#{price.to_s(:delimited, delimiter: ',')}"
  end

  def self.looks(word)
    @items = Item.where("name LIKE?","%#{word}%")
  end

end
