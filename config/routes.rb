Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  #ログイン機能のルーティング
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  #ユーザーの新規登録機能
  resources :users, only: %i[new create]
  resources :posts, only: %i[index new create show] do
    resources :comments, only: %i[create], shallow: true
  end

end
