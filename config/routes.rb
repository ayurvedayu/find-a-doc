Spree::Core::Engine.routes.draw do

  
  resources :verifications, only: [:edit, :update]

  resources :timings, only: :index

  devise_scope :spree_user do
    get '/doctor-signup' => 'user_registrations#doctor_signup', :as => :doctor_signup
    get '/clinic-signup' => 'user_registrations#clinic_signup', :as => :clinic_signup
  end

  resources :appointments, only: [:show]

  resource :account, :controller => 'users' do
    resources :clinics, shallow: true do
      member do
        resources :images, module: 'clinic', as: 'clinic_images'
      end
    end
    resources :appointments, except: [:new, :destroy]
    authenticate :spree_user do
      resources :verifications, only: [:update, :create, :destroy] do
        post 'complete', on: :collection
      end
      resources :doctor_employments, only: [:destroy]
    end
  end
  get 'account/appointments/new/:doctor_employment_id', to: 'appointments#new', as: :new_account_doctor_appointment, defaults: { for: 'doctor'}
  get 'account/clinic_appointments/new/:clinic_id', to: 'appointments#new', as: :new_account_clinic_appointment, defaults: { for: 'clinic'}
  get 'account/appointments/:id/cancel', to: 'appointments#cancel', as: 'cancel_appointment'
  get 'account/appointments/:id/complete', to: 'appointments#complete', as: 'complete_appointment'
  get 'account/appointments/:id/verify', to: 'appointments#verify', as: 'verify_appointment'
  post 'account/appointments/:id/comfirm', to: 'appointments#confirm', as: 'confirm_appointment'

  resources :doctors, only: :show do
  end

  namespace :doctor do
    resources :images
  end

  resources :images

  get 'find-a-doctor', to: 'doctor_search#index', as: 'doctor_search'
  get 'find-a-doctor/results', to: 'doctor_search#show', as: 'doctor_search_results'

end
