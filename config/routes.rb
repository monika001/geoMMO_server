Rails.application.routes.draw do
  root 'static_pages#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'log_out'

  namespace :api do
    namespace :v1 do
      get 'sample', to: 'sample_service#sample'
    end
  end
end
