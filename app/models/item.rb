class Item < ApplicationRecord

#商品単価の3桁ごとに「,」を入れるメソッドです(山田)
  def number_to_currency(price)
    "#{price.to_s(:delimited, delimiter: ',')}円"
  end
end
