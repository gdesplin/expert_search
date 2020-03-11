Rails.application.routes.draw do
  resources :experts do
    member do
      put :add_friend
      get :friend_search
    end
  end
  root to: "experts#index"
end
