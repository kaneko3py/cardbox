json.array!(@cards) do |card|
  json.extract! card, :id, :user_id, :no, :question, :answer, :comment
  json.url card_url(card, format: :json)
end
