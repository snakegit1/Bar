# == Schema Information
#
# Table name: drinks
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  drink_category_id  :integer
#  enable             :boolean          default(TRUE)
#

class Drink < ActiveRecord::Base
	belongs_to :drink_category
	has_many :pub_drinks, :dependent => :destroy
	has_attached_file :image,styles: { medium: "600x600>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
	do_not_validate_attachment_file_type :image
	#attr_accessible  :id,:name,:description,:image





end
