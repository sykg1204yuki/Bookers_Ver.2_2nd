Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get 'home/about' => "homes#about"
  resources :books do 
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    
  end 
  
  
  resources :users, only: [:show,:index, :edit, :update] do 
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as:'followings'
    #Follows Usersの一覧作成のため
    get 'followers' => 'relationships#followers', as:'followers'
    #Followers Usersの一覧作成のため
    
  end 

end
