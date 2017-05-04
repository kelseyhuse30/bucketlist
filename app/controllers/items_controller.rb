class ItemsController < ApplicationController

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
      @item.category_id = @category.id
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
end