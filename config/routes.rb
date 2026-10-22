Rails.application.routes.draw do
  devise_for :users

  # ホーム画面(ログイン導線)
  root "home#index"

  # ゲストログイン
  post "guest_login", to: "guest_sessions#create", as: :guest_login

  # マイホーム(個人)
  resource :my_home, only: :show, controller: "my_homes"

  # グループ
  resources :groups, only: %i[index show new create] do
    resource :group_home, only: :show, controller: "group_homes"
  end
end
