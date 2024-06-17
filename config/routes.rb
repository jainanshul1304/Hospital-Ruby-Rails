Rails.application.routes.draw do
#   get 'welcome/index'
#   For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

#   root 'welcome#index'
#   resources :articles do
#     resources :comments
#   end
Rails.application.routes.draw do
  resources :patients do
    collection do
      get :graph
    end
end
resources :users, only: [:new, :create, :index]
resources :patients


#   resources :users, except: [::destroy]
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'login', to: 'logins#new'
  post 'login', to: 'logins#create'
  delete 'logout', to: 'logins#destroy'
  post 'generate', to: 'patients#generate'
  delete 'clean', to: 'patients#clean'
  get 'dashboard', to: 'patients#dashboard'

  root 'patients#index'
end
end
