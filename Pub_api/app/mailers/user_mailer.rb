class UserMailer < ApplicationMailer
  default :from => "Boxfree <contact@box-free.com>"

  def welcome_admin_email(user)
    @user = user
    @url  = 'http://go.box-free.comr'
    mail(to: @user.email, subject: 'Bienvenido a Boxfree')
  end

  def orders(order)
    @order = order
    mail(to: order.user.email, subject: "Detalle de tu cuenta en #{order.pub.name} el #{order.created_at}")
  end
end
