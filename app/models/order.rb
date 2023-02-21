class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  belongs_to :member

  enum payment_method: ["クレジットカード", "銀行振込"]
  enum order_status: ["入金待ち","入金確認","制作中","発送準備中","発送済み"]
  

  def set_date
    created_at.strftime("%Y/%-m/%-d/ %-H:%M:%S")
  end
end
