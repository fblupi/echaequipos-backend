json.partial! 'api/v1/affiliations/affiliation', affiliation: affiliation
json.user affiliation.user, partial: 'api/v1/users/user', as: :user