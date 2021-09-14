Rails.application.routes.draw do
  root 'users#top'
  devise_for :users
  resources :users, only:[:show, :index] do
    resource :relationships, only:[:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
