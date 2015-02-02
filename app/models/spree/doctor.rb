class Spree::Doctor < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :doctor_employments
  has_many :clinics, through: :doctor_employments
  accepts_nested_attributes_for :doctor_employments

  belongs_to :user
  has_and_belongs_to_many :specialties

  has_many :appointments, through: :doctor_employments
  has_many :reviews, through: :appointments
  has_many :recommendations
  # validate :has_specialties?

  before_validation :delete_empty_employments

  def delete_empty_employments
    doctor_employments.each do |empl|
      if empl.clinic.nil? && empl.consultation_price.nil?
        empl.destroy
      end
    end
  end

  def has_specialties?
    errors[:base] << 'must have at least one specialty' if self.specialties.blank?
  end

  def slug_candidates
    [
      :name,
      [:name, :clinic_id],
      [:name, :clinic_id, :user_id]
    ]
  end
end
