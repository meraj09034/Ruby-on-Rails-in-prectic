class User < ActiveRecord::Base
	validates :name, length: {minimum: 5}, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
end