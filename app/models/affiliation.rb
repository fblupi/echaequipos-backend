class Affiliation < ApplicationRecord
  AFFILIATION_TYPES = %w[invitation normal admin].freeze

  validates :group, :user, :affiliation_type, presence: true
  validates_uniqueness_of :group, scope: :user

  belongs_to :group
  belongs_to :user
  has_many :created_matches, foreign_key: 'affiliation_id', class_name: 'Match'
  has_many :players
  has_and_belongs_to_many :positions

  enum affiliation_type: AFFILIATION_TYPES, _prefix: true

  AFFILIATION_TYPES.each do |type|
    define_method "#{type}?" do
      affiliation_type == type
    end
  end

  def accept_invitation
    change_affiliation_type('normal')
  end

  def upgrade_admin
    change_affiliation_type('admin')
  end

  def downgrade_normal
    change_affiliation_type('normal')
  end

  private

  def change_affiliation_type(type)
    update(affiliation_type: type)
  end
end
