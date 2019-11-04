class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :movie
    validates :title, presence: true
    validates :comment, presence: true
    validates :movie_id, presence: true
end
