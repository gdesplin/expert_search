Rails.application.routes.draw do
  resources :experts
  root to: "experts#index"
end
