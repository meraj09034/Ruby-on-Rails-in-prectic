json.array!(@admins) do |admin|
  json.extract! admin, :id, :first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id, :user_id
  json.url admin_url(admin, format: :json)
end
