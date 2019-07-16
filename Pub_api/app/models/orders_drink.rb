# == Schema Information
#
# Table name: orders_drinks
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  drink_id   :integer
#  price      :float(24)
#  quantity   :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrdersDrink < ActiveRecord::Base
    belongs_to :order
    belongs_to :drink
end
