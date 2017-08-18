Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'setup_chat#index'

  resources :setup_chat, only: [:index, :create] do
    get '/username' => 'chat#enter_username'
    post '/start_chat' => 'chat#start_chat'
  end

  resources :chat, only: [:index] do
  	get '/all_messages' => 'chat#all_messages'
  end

  resources :message, only: [:index, :create] do
  end
end
