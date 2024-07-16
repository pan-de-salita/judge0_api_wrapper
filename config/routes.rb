Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Statuses
      get '/statuses', to: 'statuses#index'

      # Languages
      get '/all_languages', to: 'languages#index'
      get '/active_languages', to: 'languages#index_active'
      get '/archived_languages', to: 'languages#index_archived'

      # Submissions
    end

    # add other versions as needed
  end
end
