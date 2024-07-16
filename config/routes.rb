Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Statuses
      get '/statuses', to: 'statuses#index'

      # Languages
      get '/languages', to: 'languages#index'

      # Submissions
    end

    # add other versions as needed
  end
end
