ExampleApp::Application.routes.draw do |map|
  root 'pages#show', :page => :home
  resources :projects do
    member do
      get :budget
      get :history
    end
  end
  get '/pages/:page' => 'pages#show', :as => :page
end
