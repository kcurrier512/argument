json.array!(@pair_memberships) do |pair_membership|
  json.extract! pair_membership, :id
  json.url pair_membership_url(pair_membership, format: :json)
end
