class Spree::Specialty < ActiveRecord::Base
  has_many_and_belongs_to :doctors
end
