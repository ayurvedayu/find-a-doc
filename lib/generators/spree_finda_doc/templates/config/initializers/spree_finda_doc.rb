SpreeFindaDoc.setup do |config|
  # login and pass for sms gateway
  config.bhash_login = Rails.secrets.bhash_login
  config.bhash_pass = Rails.secrets.bhash_pass
end