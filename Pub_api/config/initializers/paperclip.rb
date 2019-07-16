# config/initializers/paperclip.rb
Paperclip.interpolates(:placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("missing_pub.png")
end
