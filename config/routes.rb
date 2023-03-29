Rails.application.routes.draw do

# Author
get '/authors' ,to: 'authors#index'
post '/authors', to: 'authors#create'
get   '/authors/:id', to: 'authors#show'
put   '/authors/:id', to: 'authors#update'
delete '/authors/:id', to: 'authors#destroy'  
#books
get '/books', to: 'books#index'
post '/books', to: 'books#create'
get '/books/:id', to: 'books#show'
put '/books/:id', to: 'books#update'
delete '/books/:id', to: 'books#destroy'
#publisher
get '/publishers', to: 'publishers#index'
post '/publishers', to: 'publishers#create'
get '/publishers/:id', to: 'publishers#show'
patch '/publishers/:id', to: 'publishers#update'
put '/publishers/:id', to: 'publishers#update'
delete '/publishers/:id', to: 'publishers#destroy'
# readings
get '/readings', to: 'readings#index'
post '/readings', to: 'readings#create'
get '/readings/:id', to: 'readings#show'
patch '/readings/:id', to: 'readings#update'
delete '/readings/:id', to: 'readings#destroy'
#users
  get '/users/me', to: 'users#me'
  post '/users/register', to: 'users#register'
  post '/users/login', to: 'users#login'
  post '/users/logout', to: 'users#logout'
  get '/users/:id/books', to: 'users#user_books'
  post '/users/me/read', to: 'users#mark_book_as_read'


end
