Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  #パスワードリセットのルーティング
  resources :password_resets, only: %i[new create edit update]

  #ウイスキー豆知識のルーティング
  resource :konwledge, only: %i[show] do
    collection do
      get 'history'
      get 'whiskey'
      get 'country'
      get 'how_to_drink'
    end
  end

  #プライバシポリシーのルーティング
  get "homes/privacy_policy", to: "homes#privacy_policy"
  get "homes/terms", to: "homes#terms"

  #指定アカウントでのログイン認証のルーティング
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
  resources :profiles, only: %i[show edit update]

  #admin機能のルーティング
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :posts, only: %i[index show edit update destroy]
  end
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
