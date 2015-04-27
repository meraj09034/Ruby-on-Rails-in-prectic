class Fan < ActiveRecord::Base
  validates :date_of_birth, presence: true, date: {:before => Time.now - 5.year, message: 'must be 5 years ago'}
  validates :first_name, :last_name,:genre_ids,:country_id, presence: true
  belongs_to :country
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :fan_genres, dependent: :destroy
  has_many :genres, :through => :fan_genres
  accepts_nested_attributes_for :fan_genres
  validates :fan_genres, :length => { :minimum => 1}

end
