Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Setup the route for the line server.
  # Format: GET localhost:3000/api/v1/lines/:id
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get "lines/:id", to: 'lines#show'
    end
  end
end
