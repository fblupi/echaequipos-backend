json.current @affiliations[:current], partial: 'api/v1/affiliations/affiliation_with_group', as: :affiliation
json.invitations @affiliations[:invitations], partial: 'api/v1/affiliations/affiliation_with_group', as: :affiliation
