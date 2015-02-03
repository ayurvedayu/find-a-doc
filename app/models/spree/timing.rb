class Spree::Timing < ActiveRecord::Base
  belongs_to :timeslotable, polymorphic: true
end
