Rails.application.routes.draw do

  resources :plans

  resources :prediction_economies

  resources :accounts

  resources :articles

  resources :cards

  resources :charges

  resources :bank_accounts

  resources :prediction_games

  resources :games

  resources :teams

  resources :sports

  resources :predictions

#  resources :predictors

 #get ':prediction_game(/:league(/:team))' => "prediction_games#findpredictiongames"

  devise_for :users
  devise_for :admins
  devise_for :predictors

  root :to => 'pages#home'

  #temporary route XXX---XXXXX remove this
  get "javatest" => "javascripts#dynamicgames.js"

  get 'home' => 'pages#home'

  get 'gamedash' => "games#index"

  get "about" => "pages#about"

  get "login" => "devise/sessions#new"

  get 'dashboard' => 'pages#dashboard'

  get 'get_started' => 'pages#signup_dual_details'

  get 'all_categories' => 'pages#prediction_type_full_index'

  get 'predictoradminindex' => 'predictors#index'

  get 'posts' => 'articles#index'

  get 'experts' => 'predictors#predictorindex', as: 'predictorindex'

  get '/find-experts/:expert_type' => 'pages#findexperts', as: 'findexperts'

  get 'sportdashboard' => 'sports#index'

  # get 'subscribe' => 'cards#create'

  post 'cards_default' => 'cards#make_default'

  post 'update_predictor_price' => 'predictors#update_predictor_price'

  post 'bank_account_default' => 'bank_accounts#make_default'

  get '/:predictor/premium/confirm' => 'predictors#subscribe_confirm', as: 'subscribe_confirm'

  get 'subscribe' => 'subscriptions#create'

  get 'go_premium' => 'pages#premium_landing'

  get '/plan/:plan/confirm' => 'plans#confirm', as: 'plan_confirm'

  get 'plan/:plan/purchase' => 'plans#purchase', as: 'plan_purchase'

  get 'plans' => 'plans#index'

  get 'balance' => 'predictors#predictorbalance'

  get 'buy_prediction_game' => 'prediction_games#buy'

  get 'subscribe_to_predictor' => 'predictors#subscribe'


  get 'follow_predictor' => 'predictors#follow'

  get 'predictorpayeeedit' => 'accounts#edit'
  get 'bank_account_new' => 'bank_accounts#new'

  get 'find_NBA_predictions' => 'prediction_games#findnbapredictiongames'
  get 'find_NFL_predictions' => 'prediction_games#findnflpredictiongames'
  get 'find_MLB_predictions' => 'prediction_games#findmlbpredictiongames'
  get 'find_NHL_predictions' => 'prediction_games#findnhlpredictiongames'

  get '/users/edit/payments' => 'cards#index', as: 'payments'


  get '/:predictor_id/sports/:league/:id' => 'prediction_games#show', as: 'show_prediction_games'
  
  get '/events/sports/:league' => 'games#findgames', as: 'find_prediction_games'

  get 'sports/leagues/:league/games/:id' => 'games#show', as: 'gameshow'

  get 'sports/leagues/:league/games/:id/predictions' => 'pages#gamepredictionindex', as: 'gamepredictionindex'

  get '/:league/games/:id/posts' => 'pages#gamearticleindex', as: 'gamearticleindex'

  get 'sports/leagues/:league/teams/:id' => 'teams#show', as: 'teamshow'

  get 'sports/leagues/:league/teams/:id/games' => 'teams#show_games', as: 'teamshowgames'

  get 'sports/leagues/:league/teams/:id/experts' => 'teams#expertindex', as: 'teamindexexperts'

  get 'sports/leagues/:league/teams/:id/experts' => 'teams#show_predictors', as: 'teamshowpredictors'

  get '/:league/teams/:id/games' => 'teams#teamgameindex', as: 'teamgameindex'

  get 'sports/league/:league/teams' => 'sports#teamindex', as: 'sportsteamindex'

  get 'sports/league/:league/experts' => 'sports#expertindex', as: 'sportsexpertindex'

  get '/events/sports/:league/predictions/:game_id' => 'prediction_games#findpredictiongames', as: 'find_sports_predictions'
  
  get '/predictors/sports/:league' => 'predictors#findsportspredictors', as: 'find_sports_predictors'

  #get '/:username' => 'prediction_games#nbapredictorindexpredictiongame', as: 'predictorindexpredictionsall'

  #get '/:username/:category' => 'prediction_games#nbapredictorindexpredictiongame', as: 'predictorindexpredictionscategory'

  #get '/:username/:category/league/:league' => 'prediction_games#nbapredictorindexpredictiongame', as: 'predictorindexpredictionsleague'

  get '/:username/predictions' => 'predictors#predictionindex', as: 'predictorindexpredictionsall'

  get '/:username/predictions/:category' => 'predictors#predictionindex', as: 'predictorindexpredictionscategory'

  get '/:username/' => 'predictors#predictordashboard', as: 'predictordashboard'

  get '/:username/posts' => 'predictors#articleindex', as: 'predictorindexarticlessall'

  get '/:username/posts/new/sports/:game' => 'articles#new', as: 'predictorarticlenew'

  get '/:username/posts/:id' => 'articles#show', as: 'predictorarticleshow'

  get '/:username/:category/league/:league' => 'predictors#predictionindex', as: 'predictorindexpredictionsleague'

  get '/buyprediction/sports/:id' => 'prediction_games#buy', as: 'buypredictiongame'

  get '/:username/:type/new/sports/' => 'games#sportsgamesselect', as: 'sportsgamesselect'

  get '/:username/predictions/sports/:id' => 'prediction_games#show', as: 'predictiongamesshow'

  get '/:username/subscribers' => 'predictors#subscriberindex', as: 'predictorsubscriberindex'

  get '/:league/teams/:id/predictions' => 'teams#predictionindex', as: 'teamindexpredictionsall'

  get '/:league/teams/:id/posts' => 'teams#articleindex', as: 'teamindexarticlesall'

  get ':league/posts/all/index' => 'pages#leaguearticleindex', as: 'leaguearticleindex'

  get 'sports/leagues/:league/predictions' => 'pages#leaguepredictionindex', as: 'leaguepredictionindex'

  get ':league/games' => 'pages#leaguegameindex', as: 'leaguegameindex'

  get 'sports/leagues/:league' => 'pages#leaguehome', as: 'leaguehome'

  get 'sports/leagues/:league/experts' => 'pages#league_predictors', as: 'leaguepredictors'

  get 'sports/leagues/:league/games' => 'pages#league_games', as: 'leaguegames'

  get 'editor' => 'sports#new'

  get '/posts/all/:type' => 'articles#index', as: 'articledashboard'

  get 'watchlist' =>'pages#mywatchlist'

  get 'sports-watchlist' => 'pages#sportswatchlist'
  get 'finance-watchlist' => 'pages#financewatchlist'
  get 'politics-watchlist' => 'pages#politicswatchlist'
  get 'misc-watchlist' => 'pages#miscwatchlist'

  get '/find-predictions/:prediction_type' => 'pages#findpredictions', as: 'findpredictions'

  get 'findsportspredictions' => 'prediction_games#findpredictiongames'

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

  get 'prediction/sports/new/:id' => 'prediction_games#new', as: 'newpredictiongame'

  get '/buyprediction/sports/:id' => 'prediction_games#show', as: 'showpredictiongame'

  post '/accounts/update' => 'accounts#update', as: 'accounts_update'
  

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
