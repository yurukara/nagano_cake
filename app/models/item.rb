class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_items
  belongs_to :genre
  has_one_attached :image

  with_options presence: true do
   validates :name
   validates :introduction
   validates :price
   validates :image
 end
 validates :is_active, inclusion: { in: [true, false] }

  def get_item_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end

  #商品単価の3桁ごとに「,」を表示するメソッドです(税抜)
  #下記のコードはstring型になります。計算には使用できません。(山田)
  #いらないかも、、、
  def number_to_currency
    price.to_s(:delimited)
  end

  #税込み価格の計算です。floorは小数点を表示しないよう記述しております。
  def with_tax_price
    (price*1.1).floor
  end

  def self.looks(word)
    @items = Item.where("name LIKE?","%#{word}%")
  end

end
