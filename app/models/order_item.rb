class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :quantity, numericality: { in: 1..50 }
  enum production_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3}

end
