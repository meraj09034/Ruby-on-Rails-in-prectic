json.array!(@artists) do |artist|
  json.extract! artist, :id, :first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id, :band_name, :dialog, :agree_to_privacy, :subscription, :user_id
  json.url artist_url(artist, format: :json)
end
