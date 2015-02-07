FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_finda_doc/factories'
  factory :city, class: Spree::City do
    name "Bangalore"
  end

  factory :suburb, class: Spree::Suburb do
    city
    name "anekal"
  end


  factory :clinic, class: Spree::Clinic do
    name 'First'
    suburb
    association :user, factory: :user
    description "About"
    clinic_type
    street "S N L road"
    building ""
  end

  factory :doctor_employment, class: Spree::DoctorEmployment do
    association :doctor, factory: :instant_doctor
    clinic
    consultation_price '100'
    consultation_currency 'INR'
    timings { Spree::Timing.new_for_all_weekdays(start_time: '10:00', end_time: '18:00', is_working_day: 'working') }
    factory :unverified_doctor_employment do
      association :doctor, factory: :unverified_instant_doctor
    end
  end
  factory :confirmed_user, class: Spree.user_class do
    email { generate(:random_email) }
    login { email }
    password 'secret'
    password_confirmation { password }
    authentication_token { generate(:user_authentication_token) } if Spree.user_class.attribute_method? :authentication_token
    confirmed_at Time.now
    phone_is_verified true

    factory :unverified_confirmed_user do
      phone_is_verified false
    end
    factory :confirmed_doctor_user do
      spree_roles { [ Spree::Role.doctor ]}
      factory :unverified_doctor_user do
        phone_is_verified false
      end
    end
    factory :confirmed_admin_user do
      spree_roles { [Spree::Role.find_by(name: 'admin') || create(:role, name: 'admin')] }
    end

    factory :confirmed_user_with_addreses do
      ship_address
      bill_address
    end
  end

  factory :doctor, class: Spree::Doctor do
    association :user, factory: :confirmed_doctor_user
    name 'Name'
    description 'About'
    phone '+7 985 965 63 17'
    is_for_instant_booking false
    specialties {[ FactoryGirl.create(:specialty) ]}
  end

  factory :instant_doctor, class: Spree::Doctor do
    association :user, factory: :confirmed_doctor_user 
    name 'Name'
    description 'About'
    phone '+7 985 965 63 17'
    is_for_instant_booking true
    specialties { [ FactoryGirl.create(:specialty) ] }
    factory :unverified_instant_doctor do
      association :user, factory: :unverified_doctor_user
    end
  end

  factory :clinic_type, class: Spree::ClinicType do
    name 'Ayurveda'
  end

  factory :specialty, class: Spree::Specialty do
    name 'Ayurveda'
  end

end
