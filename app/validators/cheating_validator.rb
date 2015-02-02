class CheatingValidator < ActiveModel::Validator
  def validate(record)
    if record.doctor.user.id == record.user_id
      record.errors[:base] << "You and the doctor must be different persons" 
    end
  end
end
  