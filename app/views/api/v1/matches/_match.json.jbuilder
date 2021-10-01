json.id match.id
json.name match.name
json.date match.date
json.duration match.duration
json.status match.status
json.min_players match.min_players
json.max_players match.max_players
json.location match.location
json.latitude match.latitude
json.longitude match.longitude
json.group match.group, partial: 'api/v1/groups/group', as: :group
json.creator match.creator, partial: 'api/v1/affiliations/affiliation', as: :affiliation
