Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  #ウイスキー豆知識のルーティング
  resource :konwledge, only: %i[show] do
    collection do
      get 'history'
      get 'whiskey'
      get 'country'
      get 'how_to_drink'
    end
  end

  #googleログイン認証のルーティング
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  #ログイン機能のルーティング
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'guest_login', to: 'user_sessions#guest_login'

  #google_位置情報
  get "search_shops", to: "search_shops#search"

  #ユーザーの新規登録機能
  #resources :users, only: %i[new create]にすると、エラー時にusersというURLへ遷移するためrouting errorになる！
  get 'users', to: 'users#new'
  post 'users', to: 'users#create'

  resources :posts do
    resources :comments, only: %i[create update destroy], shallow: true
    # /posts/bookmarksのURLを作っている。このURLのブックマークの一覧を表示する。
    collection do
      get 'bookmarks'
    end
  end
  # ブックマークのcreateアクションとdestroyアクション
  resources :bookmarks, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
end
