class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @lists = List.all
      erb :'lists/lists'
    else
      redirect '/login'
    end
  end

  get '/lists/new' do
    if logged_in?
      erb :'/lists/new_list'
    else
      redirect '/login'
    end
  end

  post "/lists" do
    redirect_if_not_logged_in
    if params[:title]== "" && params[:item]==""
      redirect "lists/new?error=invalid title or description"
    end
    @user = User.find_by(id: session[:user_id])
    @list = List.create(title: params[:title], item: params[:item], user_id: @user.id)
    redirect "/lists/#{@list.id}"
  end


  get '/lists/:id' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list && @list.user == current_user
        erb :'lists/show_list'
      end
    else
      redirect '/login'
    end
  end

  get '/lists/:id/edit' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list && @list.user == current_user
        erb :'lists/edit_list'
      else
        redirect '/lists'
      end
    else
      redirect '/login'
    end
 end

 patch '/lists/:id' do
   redirect_if_not_logged_in
   if params[:title]=="" && params[:description]==""
     redirect "/lists/#{@list.id}/edit?error=invalid title or description"
   else
     @list = List.find(params[:id])
     if @list && @list.user == current_user
       @list.update(params.select{|t|t=="title" || t=="item" || t=="user_id"})
       redirect "/lists/#{@list.id}"
     else
       redirect to "/lists/#{@list.id}/edit?error=invalid title or description"
     end
   end
 end

 delete '/lists/:id/delete' do
  if logged_in?
    @list = List.find_by_id(params[:id])
    if @list && @list.user == current_user
      @list.delete
    end
    redirect '/lists'
  else
    redirect '/login'
  end
 end



end
