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

    client = Omdb::Api::Client.new(api_key: "a44e8752")

    if !params["movie"].empty? #&& !Movie.find_by_title(params["movie"])
      binding.pry
      movie = client.find_by_title(params["movie"])
      db_movie = Movie.find_by_title(movie.title)
      
      if !!db_movie && movie.title == db_movie.title
        @movie = db_movie
      else
        binding.pry
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
      binding.pry
      #redirect user to post page w/ error
      redirect to :"/failure"
    end

    @user = User.find_by_id(session["user_id"])
    @post = Post.new(title: params["title"], comment: params["comment"], user_id: @user.id, movie_id: @movie.id)
    if !!@post.comment
      @post.save
    end
    #if no comment redirect to create page w/; eroor
    erb :"/posts/index.html"
  end

  # GET: /posts/5
  get "/posts/:id" do
    erb :"/posts/show.html"
  end

  # # GET: /posts/5/edit
  # get "/posts/:id/edit" do
  #   erb :"/posts/edit.html"
  # end

  # # PATCH: /posts/5
  # patch "/posts/:id" do
  #   redirect "/posts/:id"
  # end

  # # DELETE: /posts/5/delete
  # delete "/posts/:id/delete" do
  #   redirect "/posts"
  # end
end
