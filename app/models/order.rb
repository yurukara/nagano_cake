class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  belongs_to :member
  
  enum payment_method: ["クレジットカード", "銀行振込"]
  
end
