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
      erb :'/lists/new_list'
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
    if params[:list][:title].empty?
      redirect "/lists/new"
    else
      @list = List.new(title: params[:title], item: params[:item])
      if @list.save
        redirect to "/lists/#{@list.id}"
      else
        redirect to "/lists/new"
      end
    end
  else
    redirect '/login'
  end
 end

    patch '/lists/:id' do
     if logged_in?
      if params[:list][:title].empty?
        redirect "/lists/#{params[:id]}/edit"
      else
        @list = List.find_by_id(params[:id])
        if @list && @list.user = current_user
          if @list.update(:title => params[:title], :item => params[:item])
            redirect to "/lists/#{@list.id}"
          else
            redirect to "/lists/#{@list.id}/edit"
          end
        else
          redirect to '/lists'
        end
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
