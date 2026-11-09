Rails.application.routes.draw do
  # Web interface (HTML)
  root "tasks#index"

  resources :tasks do
    member do
      patch :toggle
    end
  end

  # Health check (JSON)
  get "/health", to: "health#show"

  # REST API (JSON)
  #   GET    /api/tasks
  #   GET    /api/tasks/:id
  #   POST   /api/tasks
  #   PUT    /api/tasks/:id   (PATCH also works)
  #   DELETE /api/tasks/:id
  namespace :api, defaults: { format: :json } do
    resources :tasks, only: %i[index show create update destroy]

    # Any other /api/... URL returns a JSON 404
    match "*unmatched", to: "base#not_found", via: :all
  end
end
