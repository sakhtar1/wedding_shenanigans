class ListsController < ApplicationController

  get '/lists' do
      not_logged_in
      @lists = List.all
      erb :'lists/lists'
  end

  get '/lists/new' do
    not_logged_in
    redirect '/lists/new_list'
  end

  get '/lists/:id' do
    not_logged_in
    @list = List.find_by_id(params[:id])
    erb :'lists/show_list'
  end

  get '/lists/:id/edit' do
    not_logged_in
    @list = List.find_by_id(params[:id])
    if @list && @list.user == current_user
      erb :'lists/edit_list'
    else
      redirect '/lists'
    end
 end



end
