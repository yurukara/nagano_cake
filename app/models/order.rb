class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  belongs_to :member

  enum payment_method: ["クレジットカード", "銀行振込"]

  enum order_status: {
    "入金待ち" => 0,
    "入金確認" => 1,
    "製作中" => 2,
    "発送準備中" => 3,
    "発送済み" => 4,
  }

  def set_date
    created_at.strftime("%Y/%-m/%-d/ %-H:%M:%S")
  end

end
