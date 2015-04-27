class FanGenre < ActiveRecord::Base
  belongs_to :fan
  belongs_to :genre
end
