class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :movies, through: :posts
    validates :email, presence: true
    validates :username, presence: true
    validates :password, presence: true
end
