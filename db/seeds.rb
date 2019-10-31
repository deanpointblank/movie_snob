#Seeds a whole lotta movies in to the db
require_relative '../lib/api/api.rb'
require 'omdb/api'

Db_movie_seeder.get_movies

client = Omdb::Api::Client.new(api_key: "a44e8752")

Db_movie_seeder.all.each do |movie|
    unless !!Movie.find_by_title(movie)
        movie = client.find_by_title(movie)
        unless movie.error
            Movie.create(
                :title => movie.title,
                :poster => movie.poster,
                :rating => movie.rated,
                :runtime => movie.runtime,
                :genre => movie.genre,
                :blurb => movie.plot,
                :director => movie.director
            )
        end
    end
end