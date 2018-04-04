class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
      @lists = List.all
      erb :'lists/lists'
    else
      not_logged_in
    end
  end

  get '/lists/new' do
    not_logged_in
    redirect '/lists/new_list'
  end

  get '/tweets/:id' do
    not_logged_in
    @tweet = Tweet.find_by_id(params[:id])
    erb :'lists/show_list'

  end

end
