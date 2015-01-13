class Spree::Doctor < ActiveRecord::Base
  belongs_to :clinic
  belongs_to :user
  has_and_belongs_to_many :specialties
end
