class PostsController < ApplicationController

  # GET: /posts
  get "/posts" do
    erb :"/posts/index.html"
  end

  # GET: /posts/new
  get "/posts/new" do
    erb :"/posts/new.html"
  end

  # POST: /posts
  post "/posts" do
    binding.pry

    client = Omdb::Api::Client.new(api_key: "a44e8752")
    

    searched_movies = client.search(params["movie"])
    #check if the object recieved from the serch is an error or not
    if !params["movie"].empty? && searched_movies.class.to_s != "Omdb::Api::Error"
      movie = searched_movies.first
      db_movie = Movie.find_by_title(movie.title)
      
      if !!db_movie && movie.title == db_movie.title
        @movie = db_movie
      else
        @movie = Movie.create(
          :title => movie.title,
          :poster => movie.poster,
          :rating => movie.rated,
          :runtime => movie.runtime,
          :genre => movie.genre,
          :blurb => movie.plot,
          :director => movie.director
      )
      end
    # elsif !!Movie.find_by_title(params["movie"])
    #   @movie = Movie.find_by_title(params["movie"])
    else
      #redirect user to post page w/ error
      #binding.pry
      @user = User.find_by_id(session["user_id"])
      redirect to "/posts"
    end

    @user = User.find_by_id(session["user_id"])
    @post = Post.new(title: params["title"], comment: params["comment"], user_id: @user.id, movie_id: @movie.id)
    if !@post.comment.empty? && !@post.title.empty?
      @post.save
    end
    #if no comment redirect to create page w/; eroor
    erb :"/posts/index.html"
  end

  # GET: /posts/5
  get "/posts/:id" do
    @post = Post.find_by_id(params["id"])
    erb :"/posts/show.html"
  end

  # GET: /posts/5/edit
  get "/posts/:id/edit" do
    @post = Post.find_by_id(params["id"])
    erb :"/posts/edit.html"
  end

  # PATCH: /posts/5
  patch "/posts/:id" do
    @post = Post.find_by_id(params["id"])
    @post.title = params["title"]
    @post.comment = params["comment"]
    @post.save
    redirect "/posts/#{@post.id}"
  end

  # DELETE: /posts/5/delete
  delete "/posts/:id/delete" do
    @post = Post.find_by_id(params["id"])
    @post.delete
    @user = User.find_by(session["user_id"])
    erb :"/posts/index.html"
  end
end
