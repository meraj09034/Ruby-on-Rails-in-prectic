class Executive < ActiveRecord::Base
  validates :date_of_birth, presence: true
  validates :first_name, :last_name, presence: true
  belongs_to :country
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :executive_genres, dependent: :destroy
  has_many :genres, :through => :executive_genres
  accepts_nested_attributes_for :executive_genres
end
