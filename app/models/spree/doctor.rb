class Spree::Doctor < ActiveRecord::Base
  belongs_to :clinic
  belongs_to :user
  has_many_and_belongs_to :specialties
end
