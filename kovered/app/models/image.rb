class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :profile_image, ProfileImageUploader
  mount_uploader :cover_image, CoverImageUploader
end
