# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  pub_id         :integer
#  price          :float(24)
#  status         :boolean          default(FALSE)
#  ip             :string(255)
#  payment_method :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  token          :string(255)
#

class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :pub
    has_many :orders_drink, :dependent => :destroy

    STATUSES = {
        NOT_USED: false,
        USED: true
    }

    def self.calculate_price(pub_id, drinks)
        total = 0
        drinks.each do |drink|
            total += PubDrink.find_by({pub_id: pub_id, id: drink[:id]}).price * drink[:quantity]
        end
        total
    end

    def get_drinks
        result = []
        self.orders_drink.each do |od|
            result << {
                name: od.drink.name,
                category: od.drink.drink_category.name,
                price: od.price,
                quantity: od.quantity,
                created_at: od.created_at
            }
        end
        result
    end
end
