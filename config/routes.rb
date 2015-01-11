Spree::Core::Engine.routes.draw do

  resources :doctors, only: :show


  get 'find_a_doctor', to: 'doctor_search#index', as: 'doctor_search'

  get 'find_a_doctor/results', to: 'doctor_search#show', as: 'doctor_search_results'


  # Add your extension routes here
end
