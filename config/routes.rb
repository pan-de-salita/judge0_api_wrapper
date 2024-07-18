# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Statuses
      get '/statuses', to: 'statuses#index'

      # Languages
      get '/languages', to: 'languages#index'
      get '/language/:language_id', to: 'languages#show'

      # Submissions
      post '/write_submission', to: 'submissions#create'
      get '/read_submission', to: 'submissions#show'
    end

    # add other versions as needed
  end
end
