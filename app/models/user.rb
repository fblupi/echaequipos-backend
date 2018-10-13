class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :affiliations
  has_many :groups, through: :affiliations

  def current_affiliations
    affiliations.where.not(affiliation_type: 'invitation')
  end

  def invitation_affiliations
    affiliations.where(affiliation_type: 'invitation')
  end

  def create_group(name: nil, location: nil)
    return if name.blank?
    group = Group.create(name: name, location: location)
    return unless group
    Affiliation.create(group: group, user: self, affiliation_type: 'admin')
    group
  end
end
