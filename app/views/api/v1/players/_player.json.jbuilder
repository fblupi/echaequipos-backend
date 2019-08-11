json.id player.id
json.attendance player.attendance
json.affiliation player.affiliation, partial: 'api/v1/affiliations/affiliation', as: :affiliation
json.match player.match, partial: 'api/v1/affiliations/match', as: :match
