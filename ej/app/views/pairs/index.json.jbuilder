json.array!(@pairs) do |pair|
  json.extract! pair, :id
  json.url pair_url(pair, format: :json)
end
