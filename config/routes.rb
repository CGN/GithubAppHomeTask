Rails.application.routes.draw do

  get 'callback', to: 'home#callback'

  get 'logout', to: 'home#logout'

  get 'bonus', to: 'bonus#index'

  get 'modified_page', to: 'bonus#bonus_modified_page'

  get 'update_repo', to: 'bonus#update_repo'

  root to: 'home#index'
end
