class Address < ApplicationRecord

  belongs_to :member

  validates :address, presence:true
  validates :postal_code, presence:true
  validates :shipping_name, presence:true
  # エラーメッセージは未実装です(時間に余裕があればつける)

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + shipping_name
  end
end
