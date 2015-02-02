class Spree::Review < ActiveRecord::Base
  # belongs_to :doctor
  # belongs_to :user
  belongs_to :appointment

  # validates_with CheatingValidator
  validates_presence_of :text
end
