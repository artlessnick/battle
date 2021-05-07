Rails.application.routes.draw do
  root                   'static_pages#home'
  get 'help'          => 'static_pages#help'
  get 'signup'        => "users#new"
  get 'login'         => 'sessions#new'
  post 'login'        => 'sessions#create'
  get 'logout'        => 'sessions#destroy'
  get 'start'         => 'gameprocesses#start_game'
  get 'question'      => 'gameprocesses#question_for_game'
  get 'submit_answer' => 'gameprocesses#submit_answer'
  get 'statistics'    => 'users#statistics'
  get 'rating'        => 'users#index'
  get 'addquestions'  => 'add_questions#new_questions'
  post 'addquestions' => 'add_questions#create_questions'
  post 'users/admin_true'
  post 'users/admin_false'


  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
