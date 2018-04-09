Rails.application.routes.draw do
  get 'admin', to: 'admin#index'

  patch 'admin/update'

  get '/', to: 'main#index'

  devise_for :users
end
