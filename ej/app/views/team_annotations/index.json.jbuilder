json.array!(@team_annotations) do |team_annotation|
  json.extract! team_annotation, :id
  json.url team_annotation_url(team_annotation, format: :json)
end
