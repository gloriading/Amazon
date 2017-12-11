Rails.application.routes.draw do
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
      resources :reviews, only: [:create, :destroy]
  end

end
