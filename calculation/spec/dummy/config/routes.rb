Rails.application.routes.draw do
  mount Calculation::Engine => "/calculation"
end
