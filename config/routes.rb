Rails.application.routes.draw do
  root 'static_pages#index'

  namespace :api, defaults: { format: 'json'  } do
    namespace :v1 do
      get 'sample', to: 'sample_service#sample'

      resource :user, only: [:create]
    end
  end
end
