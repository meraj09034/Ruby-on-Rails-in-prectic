json.array!(@fans) do |fan|
  json.extract! fan, :id, :first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id, :fav_genre, :agree_to_privacy, :subscription, :user_id
  json.url fan_url(fan, format: :json)
end
