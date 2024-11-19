Rails.application.routes.draw do
  root "movies#index"

  resources :movies, only: %i[index] do
    get :recommendations, on: :collection
    get :user_rented_movies, on: :collection
    post :rent, on: :member
  end
end
