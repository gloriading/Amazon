Rails.application.routes.draw do
  # get 'tags/index'
  get('/tags/', to: 'tags#index')
  # get 'tags/show'
  get('/tags/:id', to: 'tags#show', as: :tag)

  get('/', {to: 'welcome#index', as: :home})
  get('/about', {to: 'welcome#about'})

  get('/contact', {to: 'contact#new'})
  post('/contact_submit', {to: 'contact#create'})
  #
  # get('/products/new', to: 'products#new', as: :new_product)
  # post('/products', to: 'products#create', as: :products)
  #
  # get('/products/:id', to: 'products#show', as: :product)
  # get('/products/', to: 'products#index')
  #
  # delete('/products/:id', to: 'products#destroy')
  #
  # get('/products/:id/edit', to: 'products#edit', as: :edit_product)
  # patch('/products/:id', to: 'products#update')

  resources :products do
      resources :reviews do
        resources :loves, only: [:create, :destroy], shallow: true
      end
      resources :reviews, only: [], shallow: true do 
        resources :review_votes, only: [:create, :update, :destroy], shallow: true
      end
      resources :likes, only: [:create, :destroy], shallow: true
      resources :favourites, only: [:create, :destroy], shallow: true
      collection do
        get :search
      end
      resources :votes, only: [:create, :update, :destroy], shallow: true
  end



  # User related route
  # resources :users, only: [:new, :create]
  resources :users do
      collection do # use `collection` when add new methods to the existing route
          get :edit_password
          patch :update_password
      end
  end

  # Session related route
  resource :session, only: [:new, :create, :destroy]

  # Admin related route
  namespace :admin do
    resources :dashboard, only: [:index]
  end

  # product_lists related route
  resource :product_lists, only: [:show]


  # note: this is from Brett
  # resource :reviews, only: [] do
  #   patch :hide
  # end

end
