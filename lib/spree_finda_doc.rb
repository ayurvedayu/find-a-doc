require 'spree_core'
require 'spree_finda_doc/engine'

module SpreeFindaDoc

  @@configured = false

  mattr_accessor :bhash_login
  @@bhash_login = nil

  mattr_accessor :bhash_pass
  @@bhash_pass = nil

  def self.setup
    @@configured = true
    yield self
  end
end