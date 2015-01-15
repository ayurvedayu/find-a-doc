class Spree::Clinic < ActiveRecord::Base
  belongs_to :suburb
  validates_associated :suburb 
  accepts_nested_attributes_for :suburb

  belongs_to :user
  belongs_to :clinic_type
  has_many :doctors

  geocoded_by :full_address
  after_validation :geocode

  validates_presence_of :suburb, :name

  def full_address
    "#{building} #{street}, #{suburb.name}, #{suburb.city.name}, IN"
  end

  def to_s
    name
  end
end
