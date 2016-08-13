Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  devise_for :users, 
              :controllers => {:registrations => "my_devise/registrations",
              :omniauth_callbacks => "omniauth_callbacks"}
              
  resources :posts do
    member { post :vote }
  end

  devise_scope :user do
    get '/fetch_user_friends', to: 'omniauth_callbacks#fetch_user_friends'
  end


  get '/show', to: 'users#show'
  get '/top_upvoted_user', to: 'users#top_upvoted_user'
  get '/show_my_posts', to: 'posts#show_all_post_of_current_user'
  get '/:id', to: 'posts#display_post_of_current_user', as: :display_post
  delete '/posts/:id', to: 'posts#destroy', as: :destroy_post
end
