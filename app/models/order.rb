class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer

  with_options presence: true do
    validates :postal_code
    validates :address
    validates :payment_method
    validates :name
  end

  def full_deliveries
    self.postcode + self.address + self.name
  end

end

