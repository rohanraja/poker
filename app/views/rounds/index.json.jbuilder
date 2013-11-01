json.array!(@rounds) do |round|
  json.extract! round, :pot, :big_blind, :small_blind, :call_value
  json.url round_url(round, format: :json)
end
