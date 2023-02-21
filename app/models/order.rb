class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  belongs_to :member

  enum payment_method: ["クレジットカード", "銀行振込"]
  enum order_status: {payment_waiting: 0,  payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4}

end
