Rails.application.routes.draw do

  get 'callback', to: 'home#callback'

  get 'logout', to: 'home#logout'

  root to: 'home#index'
end
