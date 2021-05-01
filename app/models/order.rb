class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer

  # with_options presence: true do
  #   validates :postal_code
  #   validates :address
  #   validates :payment_method
  #   validates :name
  # end

  enum payment_method: {クレジットカード:1, 銀行振込:2}
  enum status: {入金待ち:0,入金確認:1,製作中:2,発送準備中:3,発送済み:4}

  def full_deliveries
    self.postcode + self.address + self.name
  end

end

