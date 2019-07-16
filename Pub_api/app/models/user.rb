# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string(255)      default("email"), not null
#  uid                    :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  image                  :string(255)
#  email                  :string(255)
#  tokens                 :text(65535)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  super_admin            :boolean          default(FALSE)
#  lastname               :string(255)
#  braintree_customer_id  :string(256)
#  born_date              :date
#  genre                  :string(1)
#

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  include ::DeviseTokenAuth::Concerns::User
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_one :pub
  attr_accessor :token

  def send_welcome_email_admin
    if admin
      UserMailer.welcome_admin_email(self).deliver
    end
  end

  def has_payment_info?
    self.braintree_customer_id
  end

  def generate_client_token
    if !self.has_payment_info?
      result = Braintree::Customer.create(
        email: self.email
      )
      self.braintree_customer_id = result.customer.id
      self.save
    end

    Braintree::ClientToken.generate(customer_id: self.braintree_customer_id)
  end

end
