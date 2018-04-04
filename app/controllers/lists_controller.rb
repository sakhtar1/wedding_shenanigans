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



end
