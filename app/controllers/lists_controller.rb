class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
      @lists = List.all
      erb :'lists/lists'
    else
      redirect '/login'
    end
  end

  get '/lists/new' do
    if logged_in?
      redirect '/lists/new_list'
    else
      redirect '/login'
    end

  end

  get '/lists/:id' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      erb :'lists/show_list'
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

 post '/lists' do
  if logged_in?
    if params[:title].empty? && params[:item].empty?
      redirect "/tweets/new"
    else
      @user = User.find_by(id: session[:user_id])
      @list = List.create(title: params[:title], item: params[:item], user_id: @user.id)
      redirect to "/lists"
    end
   else
    redirect '/login'
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
