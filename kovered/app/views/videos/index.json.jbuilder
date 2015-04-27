json.array!(@videos) do |video|
  json.extract! video, :id, :link, :title, :published_at, :likes, :dislikes, :uid
  json.url video_url(video, format: :json)
end
