json.array!(@blogs) do |blog|
  json.extract! blog, :name, :author, :content
  json.url blog_url(blog, format: :json)
end
