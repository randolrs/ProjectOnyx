Rails.application.routes.draw do

  resources :prediction_games

  resources :games

  resources :teams

  resources :sports

  resources :predictions

 #get ':prediction_game(/:league(/:team))' => "prediction_games#findpredictiongames"

  devise_for :users
  devise_for :admins
  devise_for :predictors

  root :to => 'pages#home'

  #temporary route XXX---XXXXX remove this
  get "javatest" => "javascripts#dynamicgames.js"

  get 'home' => 'pages#home'

  get "about" => "pages#about"

  get "signup" => "pages#selectsignup"

  get "login" => "devise/sessions#new"

  get 'dashboard' => 'prediction_games#index'

  get 'sportdashboard' => 'sports#index'

  get 'find_NBA_predictions' => 'prediction_games#findnbapredictiongames'
  get 'find_NFL_predictions' => 'prediction_games#findnflpredictiongames'
  get 'find_MLB_predictions' => 'prediction_games#findmlbpredictiongames'
  get 'find_NHL_predictions' => 'prediction_games#findnhlpredictiongames'

  get 'editor' => 'sports#new'

  get 'watchlist' =>'pages#mywatchlist'

  get 'sports-watchlist' => 'pages#sportswatchlist'
  get 'finance-watchlist' => 'pages#financewatchlist'
  get 'politics-watchlist' => 'pages#politicswatchlist'
  get 'misc-watchlist' => 'pages#miscwatchlist'

  get 'find_predictions' => 'pages#findpredictions'

  get 'findsportspredictions' => 'prediction_games#findpredictiongames'

  # get 'gamesearch' =>'prediction_games#findpredictiongames'

  #prediction_games.search "gamesearch", :controller => "search"

  #get 'predictor_signup' => 'predictor#registrations#new'

  #get 'predictor_signin' => 'predictor#sessions#new'



  get 'predictor_signin' => 'predictors#session#new'

  get 'myclosedpredictions' => 'prediction_games#index_closed'

  get 'predictiontype' => 'predictions#typeselect'

  get 'predictorpricing' => 'pages#predictorpricing'

  get 'sportsprediction' => 'predictions#newsportsprediction'

  get 'financeprediction' => 'predictions#newfinanceprediction'

  get 'miscprediction' => 'predictions#newmiscprediction'

  get 'admineditor' => 'admin#editor'

  get 'sportedit' => 'sports#index'

  get 'teamedit' => 'teams#index'

  get 'add_teams' => 'teams#new'

  get 'gamescore' => 'games#score'

  get 'sportpredictiontype' => 'pages#selectsportsprediction'

  get 'gameprediction' => 'prediction_games#index' #need

  get 'gameselect' => 'games#gameselect'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
