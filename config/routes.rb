Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
  get '/', to: 'welcome#index'

  resources :shelters do
    resources :pets, only: [:new, :create, :index]
    resources :reviews, only: [:new, :create, :update, :edit, :destroy]
  end
  # get '/shelters', to: 'shelters#index'
  # get '/shelters/new', to: 'shelters#new'
  # post '/shelters', to: 'shelters#create'
  # get '/shelters/:id', to: 'shelters#show'
  # get '/shelters/:id/edit', to: 'shelters#edit'
  # patch '/shelters/:id', to: 'shelters#update'
  # delete '/shelters/:id', to: 'shelters#destroy'

  # get 'shelters/:shelter_id/pets/new', to: 'pets#new'
  # post 'shelters/:shelter_id/pets/', to: 'pets#create'
  # get 'shelters/:shelter_id/pets', to: 'pets#index'

  # get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  # patch '/shelters/:shelter_id/reviews/:id', to: 'reviews#update'
  # post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  # get '/shelters/:shelter_id/reviews/:id/edit', to: 'reviews#edit'
  # delete '/shelters/:shelter_id/reviews/:id', to: 'reviews#destroy'

  resources :pets do
    resources :applications, only: [:index]
  end
  # get '/pets', to: 'pets#index'
  # get '/pets/:id', to: 'pets#show'
  # get '/pets/:id/edit', to: 'pets#edit'
  # patch '/pets/:id', to: 'pets#update'
  # delete '/pets/:id', to: 'pets#destroy'
  # get '/pets/:pet_id/applications', to: 'applications#index'

  resources :applications, only: [:new, :create, :show]
  # get '/applications/new', to: 'applications#new'
  # post '/applications', to: 'applications#create'
  # get '/applications/:id', to: 'applications#show'

  patch '/pets/:pet_id/applications/:application_id', to: 'pet_applications#update'

  get '/favorites', to: 'favorites#index'
  get '/favorites/:pet_id', to: 'favorites#show'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites', to: 'favorites#destroy'
end
