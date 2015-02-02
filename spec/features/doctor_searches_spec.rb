require 'rails_helper'

feature "DoctorSearches", :type => :feature do
  it 'finds a doctor' do 
    # doctor = create(:doctor)
    # clinic = create(:clinic)
    # create(:suburb)
    # create(:)
    # empl = create(:doctor_employment, :doctor => doctor)
    empl = create(:doctor_employment)
    doctor = empl.doctor
    # FactoryGirl.lint
    visit spree.doctor_search_path
    select('Ayurveda', from: 'ds')

    fill_in('Location', with: empl.clinic.suburb.name)

    within('#by_spec') { click_button 'Go' }

    # sometimes i have issues here
    byebug unless page.has_text? "Dr. #{doctor.name}"
    expect(page).to have_text "Dr. #{doctor.name}"

    fill_in('dn', with: empl.doctor.name)
    within('#by_name') { click_button 'Go' }
    
    expect(page).to have_text "Dr. #{doctor.name}"

    fill_in('cn', with: empl.clinic.name)
    within('#by_clinic') { click_button 'Go' }

    expect(page).to have_text "Dr. #{doctor.name}"
  end

  it 'finds a doctor even if he has not specialties' do
    doctor = create(:doctor)

    doctor.specialties.destroy_all

    empl = create(:doctor_employment, doctor: doctor)

    visit spree.doctor_search_path

    fill_in('dn', with: doctor.name)
    within('#by_name') { click_button 'Go' }

    expect(page).to have_text "Dr. #{doctor.name}"
  end

end
