Rails.application.routes.draw do

  get 'callback', to: 'home#callback'

  root to: 'home#index'
end
