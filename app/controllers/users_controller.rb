class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/signup" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    # check if email is already in the database
    #   if it is redirect user back to signup page with error message
    @user = User.new(email: params["email"], username: params["username"], password: params["password"])
    if !!User.find_by_email(@user.email)
      redirect to "/signup"
    end

    if @user.save
      redirect to '/login'
    end
    # binding.pry
    # redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
