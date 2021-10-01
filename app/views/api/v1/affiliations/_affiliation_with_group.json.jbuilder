json.partial! 'api/v1/affiliations/affiliation', affiliation: affiliation
json.group affiliation.group, partial: 'api/v1/groups/group', as: :group
