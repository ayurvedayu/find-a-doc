SpreeFindaDoc.setup do |config|
  # login and pass for sms gateway
  config.bhash_login = Rails.application.secrets.bhash_login
  config.bhash_pass = Rails.application.secrets.bhash_pass

  config.gmaps_api = 'AIzaSyCqmSJ8E46Yv8vW1Mu9f1cveniy4wb1cTc'
end