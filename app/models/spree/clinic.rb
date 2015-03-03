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
  
  has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"

  # has_many :appointments, through: :doctor_employments
  has_many :appointments, as: :appointmentable

  has_and_belongs_to_many :services


  validates_presence_of :suburb, :name, :clinic_type, :phone
  validates_uniqueness_of :name

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.latitude.nil? || obj.longitude.nil? }
  after_save :parse_services

  def full_address
    "#{building} #{street} #{suburb.try(:name).titleize}, #{suburb.city.try(:name)}"
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

  def should_generate_new_friendly_id?
    name_changed?
  end

  def recommendations_total
    doctor_employments.inject(0) { |sum, n| sum + n.doctor.recommendations.count }
  end

  def slots_at date
    Spree::TimeSlot.all_for(self, date: date)
  end
end
