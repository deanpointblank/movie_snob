require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'current_test'
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def logged_in?
      session[:user_id]
    end

    def current_user
      @user ||= User.find_by(id: session[:user_id])
    end

  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
    else
      #redirect to login w/ error message
      redirect to "/login"
    end

  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

end
