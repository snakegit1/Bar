# == Schema Information
#
# Table name: pubs
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :string(255)
#  telephone1              :string(255)
#  telephone2              :string(255)
#  location                :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  image_logo_file_name    :string(255)
#  image_logo_content_type :string(255)
#  image_logo_file_size    :integer
#  image_logo_updated_at   :datetime
#  user_id                 :integer
#  bank_name               :string(255)
#  bank_account_type       :string(255)
#  bank_account_number     :string(255)
#  bank_account_rut        :string(255)
#  bank_account_email      :string(255)
#  order_index             :integer
#  enable                  :boolean          default(TRUE)
#

class Pub < ActiveRecord::Base
	belongs_to :user
	has_many :pub_drinks, :dependent => :destroy
	has_many :order, :dependent => :destroy

	has_attached_file :image_logo, styles: { medium: "600x600>", thumb: "300x300>" }, :default_url => ':placeholder'
	do_not_validate_attachment_file_type :image_logo

end
