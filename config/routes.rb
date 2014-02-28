GoalsApp::Application.routes.draw do
  root to: "users#show"
  resources :users
  resource :session
  resources :goals do
    member do
      post "toggle_privacy"
      post "toggle_completion"
    end
  end
end
