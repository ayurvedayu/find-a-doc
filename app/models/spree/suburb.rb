class Spree::Suburb < ActiveRecord::Base
  belongs_to :city
  validates_presence_of :city
end
