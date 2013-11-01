json.array!(@line_items) do |line_item|
  json.extract! line_item, :player_id, :round_id, :level, :amount, :pass
  json.url line_item_url(line_item, format: :json)
end
