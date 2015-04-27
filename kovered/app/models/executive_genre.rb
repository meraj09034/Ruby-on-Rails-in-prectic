class ExecutiveGenre < ActiveRecord::Base
  belongs_to :executive
  belongs_to :genre
end
