class ApplicationController < Sinatra::Base

	configure do
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
	end

	get '/' do
		erb :index
	end

	get '/signup' do
		erb :'users/signup'
	end


	post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/failure'
    else
      User.create(params)
      redirect '/login'
    end

  end

  get '/login' do
  	erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/account"
    else
      redirect to "/failure"
    end
  end

  get '/success' do
    if logged_in?
      erb :success
    else
      redirect "/login"
    end
  end

  get '/failure' do
  	erb :failure
  end

  get '/account' do
  	@user = User.find_by_id(session[:user_id])
  	erb :'users/show'
  end

  get '/items/new' do
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
  
end
