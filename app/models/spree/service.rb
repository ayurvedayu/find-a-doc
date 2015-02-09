class Spree::Service < ActiveRecord::Base
  has_and_belongs_to_many :clinics 
end
