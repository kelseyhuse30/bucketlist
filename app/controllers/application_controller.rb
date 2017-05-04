class ApplicationController < Sinatra::Base

	configure do
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
	end

	get '/' do
   if logged_in?
      redirect '/account'
    end
    @items = Item.all
		erb :index
	end

  get '/failure' do
  	erb :failure
  end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
  
end
