class Spree::DoctorEmployment < ActiveRecord::Base
  default_scope { where("spree_doctor_employments.status <> ? or spree_doctor_employments.status is null", statuses[:deleted]) }

  has_many :timings, as: :timeslotable
  accepts_nested_attributes_for :timings

  validates_presence_of :timings

  belongs_to :doctor
  belongs_to :clinic

  has_many :appointments, as: :appointmentable
  has_many :users, through: :appointments

  validates_numericality_of :consultation_price

  validates_uniqueness_of :clinic, scope: :doctor
  validates_presence_of :clinic


  geocoded_by :_clinic_address, :latitude => 'spree_clinics.latitude', :longitude => 'spree_clinics.longitude'

  enum status: [:active, :deleted]

  # geocoded_by :_clinic_address

  # before_validation :check_if_blank

  # def check_if_blank
  #   unless clinic && consultation_price
  #     false
  #   end
  # end

  def slots_at date
    Spree::TimeSlot.all_for_doctor(self, date: date)
  end

  # def method_missing method, args
    # byebug
    # doctor.send(method)
  # end

  [:phone, :name, :auto_confirmable?].each do |m|
    define_method m do
      doctor.send(m)
    end
  end

  def user
    doctor.user
  end


  private
    
    def _clinic_address
      clinic.full_address
    end
end
