class Order < ApplicationRecord
  belongs_to :seller
  belongs_to :customer

  # validates :category_id, presence: true
end
