require 'spree_core'
require 'spree_finda_doc/engine'

module SpreeFindaDoc

  @@configured = false

  mattr_accessor :bhash_login
  @@bhash_login = Rails.application.secrets.bhash_login

  mattr_accessor :bhash_login
  @@bhash_pass = Rails.application.secrets.bhash_pass

  def self.setup
    @@configured = true
    yield self
  end
end