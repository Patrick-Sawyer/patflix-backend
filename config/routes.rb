Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  root to: "static#home"
  post :upload, to: "videos#upload"
  get :videos, to: "videos#all_videos"
  post :uservideos, to: "videos#user_videos"
  post :video, to: "videos#get_video"
  delete :video, to: "videos#destroy"
end