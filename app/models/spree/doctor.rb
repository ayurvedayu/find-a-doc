class Spree::Doctor < ActiveRecord::Base
  has_many :doctor_employments
  has_many :clinics, through: :doctor_employments
  accepts_nested_attributes_for :doctor_employments

  belongs_to :user
  has_and_belongs_to_many :specialties

  validate :has_specialties?

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
end
