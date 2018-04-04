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
    redirect '/login'
  end

end
