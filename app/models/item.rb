class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  belongs_to :genre
  has_one_attached :image

  with_options presence: true do
   validates :name
   validates :introduction
   validates :price
   validates :image
 end

    #
 validates :is_active, inclusion: { in: [true, false] }
 #商品単価(税抜)の3桁ごとに「,」を入れるメソッドです(西宮)
  def number_to_currency
    "#{price.to_s(:delimited, delimiter: ',')}円"
  end
end
