Rails.application.routes.draw do
  get('/', {to: 'welcome#index'})
  get('/about', {to: 'welcome#about'})

  get('/contact', {to: 'contact#new'})
  post('/contact_submit', {to: 'contact#create'})
end
