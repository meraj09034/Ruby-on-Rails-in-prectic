json.array!(@executives) do |executive|
  json.extract! executive, :id, :first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id, :website, :agree_to_privacy, :subscription, :user_id
  json.url executive_url(executive, format: :json)
end
