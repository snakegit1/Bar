class Gift < ActiveRecord::Base
	belongs_to :drink
	belongs_to :user
	belongs_to :pub
end
