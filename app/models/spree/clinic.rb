class Spree::Clinic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :timings, as: :timeslotable
  accepts_nested_attributes_for :timings

  belongs_to :suburb
  validates_associated :suburb 
  accepts_nested_attributes_for :suburb

  belongs_to :user
  belongs_to :clinic_type
  has_many :doctor_employments
  has_many :doctors, through: :doctor_employments

  has_and_belongs_to_many :services

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.latitude.nil? || obj.longitude.nil? }

  validates_presence_of :suburb, :name, :clinic_type
  validates_uniqueness_of :name

  after_save :parse_services

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

  def services_list= sl
    @services_list = sl
  end

  def services_list
    services.map(&:name).join(", ")
  end

  def parse_services
    if @services_list
      @services_list.split(",").each {|sl| services.find_or_create_by name: sl.strip.titleize}
    end
  end
end
