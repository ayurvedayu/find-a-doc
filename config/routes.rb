Spree::Core::Engine.routes.draw do
  devise_scope :spree_user do
    get '/doctor-signup' => 'user_registrations#doctor_signup', :as => :doctor_signup
    get '/clinic-signup' => 'user_registrations#clinic_signup', :as => :clinic_signup
  end

  resource :account, :controller => 'users' do
      resources :clinics, shallow: true
      resources :appointments, except: [:new, :destroy]
    authenticate :spree_user do 
      resources :doctor_employments, only: [:destroy]
    end
  end
  get 'account/appointments/new/:doctor_employment_id', to: 'appointments#new', as: :new_account_appointment
  # get 'account/appointments/:id', to: 'appointments#update', as: 'cancel_appointment', defaults: { 'appointment[status]' => 'canceled'}
  # get 'account/appointments/:id', to: 'appointments#update', as: 'complete_appointment', defaults: { 'appointment[status]' => 'completed'}
  get 'account/appointments/:id/cancel', to: 'appointments#cancel', as: 'cancel_appointment'
  # post 'account/appointments/:id/cancel', to: 'appointments#cancel'
  get 'account/appointments/:id/complete', to: 'appointments#complete', as: 'complete_appointment'
  # post 'account/appointments/:id/complete', to: 'appointments#complete'

  resources :doctors, only: :show


  get 'find-a-doctor', to: 'doctor_search#index', as: 'doctor_search'

  get 'find-a-doctor/results', to: 'doctor_search#show', as: 'doctor_search_results'


  # Add your extension routes here
end
