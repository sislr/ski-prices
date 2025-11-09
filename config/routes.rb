Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  namespace :admin do
    root to: "ski_resorts#index"
    resources :price_entries
    resources :ski_passes
    resources :ski_resorts
    resources :ski_seasons
  end

  mount MissionControl::Jobs::Engine, at: "/jobs"

  root to: "ski_resorts#index"
  resources :ski_resorts, only: :index

  resources :ski_seasons, only: :show, param: :slug
  get "/:slug", to: "ski_seasons#show", as: :ski_season_short
end
