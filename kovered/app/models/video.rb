class Video < ActiveRecord::Base
  # YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  # validates :link, presence: true, format: YT_LINK_FORMAT
  belongs_to :artist
  mount_uploader :video, VideoUploader

  def set_success(format, opts)
    self.success = true
  end

  def preview_url
    # raise video.versions[:thumb].file.file.gsub("/home/sanaullah/blinqmedia/kovered360/public", "")
    # video.slice(s.index("uploads")..-1)
    video.versions[:thumb].file.file.gsub!(/.*?(?=\/uploads)/im, "")
  end
end
