json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :description, :address, :city, :state, :zipcode, :phone, :email, :parking
  json.url restaurant_url(restaurant, format: :json)
end
