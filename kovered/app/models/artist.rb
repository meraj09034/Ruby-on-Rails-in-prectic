class Artist < ActiveRecord::Base
  validates :date_of_birth, presence: true, date: {:before => Time.now - 5.year, message: 'must be 5 years ago'}
  validates :first_name, :last_name, :band_name, :genre, presence: true
  validates_formatting_of :first_name, :using => :alpha
  belongs_to :genre
  belongs_to :country
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :videos
  accepts_nested_attributes_for :videos

  def full_name
    "#{first_name.camelcase} #{last_name.capitalize}"

  end

  def full_address
    unless country.nil?
      "#{city.capitalize} #{country.name}"
    else
      "#{city.camelcase}"
    end
  end
  # has_many :fan_genres, dependent: :destroy
  # has_many :genres, :through => :fan_genres
  # accepts_nested_attributes_for :fan_genres
end
