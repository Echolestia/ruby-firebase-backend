Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  get '/api-docs/swagger.json' => proc { [200, {}, [File.read(Rails.root.join('api-docs', 'swagger.json'))]] }
  get 'chat_rooms_for_user/:user_id', to: 'chat_rooms#chat_rooms_for_user'
  get 'chat_rooms_with_messages/:id', to: 'chat_rooms#show_with_messages'


  Rails.application.routes.draw do
    resources :users
    resources :chat_rooms
    resources :chat_room_users
    resources :messages
    resources :articles
    resources :articles do
      collection do
        get 'by_user_group/:user_group', to: 'articles#by_user_group'
      end
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
  
end
