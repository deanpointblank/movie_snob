class MoviesController < ApplicationController

  # GET: /movies
  get "/movies" do
    binding.pry
    @movie = Movie.find_by_id(params["id"])
    erb :"/movies/index.html"
  end

  # GET: /movies/5
  get "/movies/:id" do
    @movie = Movie.find_by_id(params["id"])
    erb :"/movies/show.html"
  end

end
