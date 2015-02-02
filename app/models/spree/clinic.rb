class Spree::Clinic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :suburb
  validates_associated :suburb 
  accepts_nested_attributes_for :suburb

  belongs_to :user
  belongs_to :clinic_type
  has_many :doctor_employments
  has_many :doctors, through: :doctor_employments

  geocoded_by :full_address
  after_validation :geocode

  validates_presence_of :suburb, :name, :clinic_type
  validates_uniqueness_of :name

  def full_address
    "#{building} #{street}, #{suburb.name}, #{suburb.city.name}"
  end

  def to_s
    name
  end

  def slug_candidates
    [
      :name,
      [:name, :street]
    ]
  end

end
