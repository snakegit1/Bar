# == Schema Information
#
# Table name: pub_drinks
#
#  id          :integer          not null, primary key
#  price       :integer
#  description :string(255)
#  drink_id    :integer
#  pub_id      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  enable      :boolean          default(TRUE)
#

class PubDrink < ActiveRecord::Base
	belongs_to :drink
	belongs_to :pub

	def as_json (options = nil)
		super(:only => [:id, :price, :enable]).merge(:drink_category => drink.try(:drink_category), :drink_image => drink.try(:image), :drink_name => drink.try(:name))
	end
end
