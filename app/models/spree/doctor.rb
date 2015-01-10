class Spree::Doctor < ActiveRecord::Base
  belongs_to :clinic
  belongs_to :user
end
