json.array!(@users) do |user|
  json.extract! user, :id, :name, :password, :lock
  json.url user_url(user, format: :json)
end
