class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :quantity, numericality: { in: 1..50 }

end
