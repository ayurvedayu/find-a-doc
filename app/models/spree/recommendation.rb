class Spree::Recommendation < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :user

  validates_with CheatingValidator
end
