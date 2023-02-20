class OrderItem < ApplicationRecord
    validates :quantity, numericality: { in: 1..50 }
end
