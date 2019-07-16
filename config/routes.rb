Rails.application.routes.draw do
  root 'matches#index'
  resources :matches
	post 'matches/:id/up' => 'matches#up'
	post 'matches/:id/down' => 'matches#down'
end
