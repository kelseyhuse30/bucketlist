require 'pry'
class ApplicationController < Sinatra::Base

	configure do
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
	end

	get '/' do
    @user = User.find_by_id(session[:user_id])
    if @user
      redirect '/account'
    end
    @items = Item.all
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
      redirect to "/success"
    else
      redirect to "/failure"
    end
  end

  get '/success' do
    if logged_in?
      redirect '/account'
    else
      redirect "/login"
    end
  end

  get '/failure' do
  	erb :failure
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/account' do
  	@user = User.find_by_id(session[:user_id])
  	erb :'users/show'
  end

  get '/items/new' do
    erb :'items/new'
  end

  post '/items' do
    if params[:item][:name] == "" || params[:item][:description] == "" || params[:item][:location] == "" || (params[:item][:category_id] == nil && params[:category][:name] == "")
      redirect to 'items/new'
    end

    @item = Item.create(params[:item])
    @item.user_id = current_user.id
    @item.save

    if !params[:category][:name].empty?
      @category = Category.find_or_create_by(name: params[:category][:name])
      @item.category_id == @category.id
      @item.save
    end

    redirect to "/items/#{@item.id}"
  end

  get '/items/:id' do
    @item = Item.find_by_id(params[:id])
    erb :'items/show'
  end

  get '/items/:id/edit' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
      if @item.user_id == current_user.id
       erb :'items/edit'
      else
        redirect to '/'
      end
    else
      redirect to '/login'
    end
  end

  patch '/items/:id' do
    if params[:item][:name] == "" || params[:item][:description] == "" || params[:item][:location] == "" || (params[:item][:category_id] == "" && params[:category][:name] == "")
      redirect to "/items/#{params[:id]}/edit"
    else
      @item = Item.find_by_id(params[:id])
      @item.update(params[:item])
      @item.save

      if !params[:category][:name].empty?
        @category = Category.find_or_create_by(name: params[:category][:name])
        @item.category_id == @category.id
        @item.save
      end

      redirect to "/items/#{@item.id}"
    end
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    if @item.user_id == current_user.id
      @item.delete
    end
    redirect '/'
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
