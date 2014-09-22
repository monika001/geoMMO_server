Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#index'

  namespace :api, defaults: { format: 'json'  } do
    namespace :v1 do
      get 'sample',       to: 'sample_service#sample'
      get 'sample_user',  to: 'sample_service#sample_user'

      resource :user, only: [:show, :create, :update, :destroy]
      resource :session, only: [:create, :destroy]
    end
  end
end
