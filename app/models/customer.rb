class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :order, dependent: :destroy

  enum is_active: {有効会員: true, 退会済み: false}
    #有効会員はtrue、退会済み会員はfalse

    def active_for_authentication?
        super && (self.is_active === "有効会員")
    end
    #is_activeが有効の場合は有効会員(ログイン可能)
end
