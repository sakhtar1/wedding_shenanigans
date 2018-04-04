class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get "/signup" do
    if !logged_in?
		    erb :"users/sign_up"
    else
      redirect '/users/show'
    end
	end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect "/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email],:password => params[:password])
      session[:user_id] = @user.id
      redirect "/users/show"
    end
  end

  get "/login" do
    if !logged_in?
		    erb :"users/sign_up"
    else
      redirect '/users/show'
    end
	end

  post "/login" do
		 @user = User.find_by(:username => params[:username])
		 if @user && @user.authenticate(params[:password])
			 session[:user_id] = @user.id
       return_message[:status] == 'success'
      redirect "/users/show"
     else
      redirect "/signup"
		end
	end

  get "/logout" do
    if logged_in?
  		session.clear
      return_message[:status] == 'You are now logged out'
  		redirect "/users/sign_in"
    else
      redirect "/"
    end
	end

end
