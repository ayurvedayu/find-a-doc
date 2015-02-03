class Spree::Verification < ActiveRecord::Base
  belongs_to :user

  enum status: [:active, :completed, :deleted]
end
