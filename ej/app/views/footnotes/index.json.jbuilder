json.array!(@footnotes) do |footnote|
  json.extract! footnote, :id
  json.url footnote_url(footnote, format: :json)
end
