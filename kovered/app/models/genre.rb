class Genre < ActiveRecord::Base
  belongs_to :music_genre
  has_one :artist
  has_many :fan_genres
  has_many :fans, :through => :fan_genres
  has_many :executive_genres
  has_many :executives, :through => :executive_genres
end
