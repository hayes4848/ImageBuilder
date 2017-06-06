Rails.application.routes.draw do
  root to: 'image_handlers#index'

  get '/image-page', to: 'image_handlers#image_page', as: 'image_page'

  get '/download_file', to: 'image_handlers#download_file', as: 'download_file'

  post '/process_images', to: 'image_handlers#process_images', as: 'process_images'

  resources :image_handlers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
