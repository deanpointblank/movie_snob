require 'pry'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

class Db_movie_seeder


    @@movie_titles = []

    def self.get_movies
        puts "loading movies...."
        agent = Mechanize.new
        site = "https://www.imdb.com/list/ls006266261/?st_dt=&mode=detail&page=1&sort=list_order,asc"
        current_page = Nokogiri::HTML(open(site))
        while @@movie_titles.length < 1000 || !!next_page
            current_page = Nokogiri::HTML(open(site))
            crawl = agent.get(site)
            current_page.css("h3 a").each do |title|
                unless title.text.strip.empty?
                    @@movie_titles << title.text
                end
            end
            puts "#{@@movie_titles.size} out of 1000 loaded ..."
            if @@movie_titles.size >= 1000
                break
            end
            next_page = current_page.css("div.footer.filmosearch div div .flat-button")[1].attribute('href').text
            site = crawl.link_with("href" => next_page).click.uri.to_s
            
            
        end
        puts "#{@@movie_titles.size} Loaded!"
    end

    def self.all
        @@movie_titles
    end

end
