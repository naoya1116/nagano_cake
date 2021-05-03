class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre
  attachment :image

   scope :active, -> {where(is_active: true)}

end
