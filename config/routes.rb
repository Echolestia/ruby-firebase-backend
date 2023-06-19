Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  get '/api-docs/swagger.json' => proc { [200, {}, [File.read(Rails.root.join('api-docs', 'swagger.json'))]] }

  Rails.application.routes.draw do
    resources :users
    resources :chat_rooms
    resources :chat_room_users
    resources :messages
    resources :articles
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
  
end
