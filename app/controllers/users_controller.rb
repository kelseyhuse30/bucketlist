class UsersController < ApplicationController

	get '/signup' do
		@user = User.new
		erb :'users/signup'

	end

	post '/signup' do
    @user = User.new(params)
  	if @user.save
    	redirect '/login'
  	else
  		@message = @user.errors.full_messages.join(', ')
  		erb :'users/signup'
  	end
  end

  get '/account' do
  	erb :'users/show'
  end

end