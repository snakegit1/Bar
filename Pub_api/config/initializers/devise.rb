Devise.setup do |config|
  config.password_length = 4..20
  config.omniauth :facebook, "130516660799289", "f9ee3ac4cc43b5019606d152374f3c66",  callback_url: "http://www.boxfree.com/omniauth/facebook/callback"
  config.omniauth :google_oauth2, '334646069346-4npf4c7ej2gnq1dfuspesromvk6ugqnf.apps.googleusercontent.com', 'AIzaSyC2h1fVedq4GMMG_X5a0y1aBHWzsgWVhHg', {}
  config.mailer_sender = '"Boxfree" <contact@box-free.com>'  
  require 'devise/orm/active_record'
end
