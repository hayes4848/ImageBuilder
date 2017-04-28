Rails.application.routes.draw do
  root to: 'image_handlers#index'

  get '/image-page', to: 'image_handlers#image_page', as: 'image_page'

  resources :image_handlers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
