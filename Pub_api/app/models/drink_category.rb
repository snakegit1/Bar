# == Schema Information
#
# Table name: drink_categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  enable      :boolean          default(TRUE)
#

class DrinkCategory < ActiveRecord::Base
	has_many :drinks, :dependent => :destroy


 
end
