class VideoObserver < ActiveRecord::Observer

    def before_save(resource)
      unless resource.link.nil?
      video = Yt::Video.new url: resource.link
      resource.uid = video.id
      resource.title = video.title
      resource.likes = video.like_count
      resource.dislikes = video.dislike_count
      resource.published_at = video.published_at
      end
    rescue Yt::Errors::NoItems
      resource.title = ''
    end
end