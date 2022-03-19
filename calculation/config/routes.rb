Calculation::Engine.routes.draw do
  resources :calculate_totals, only: %i(create)
end
