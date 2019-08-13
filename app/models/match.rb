class Match < ApplicationRecord
  INITIAL_STATUS = 'proposal'.freeze
  MATCH_STATUSES = %w[proposal confirmed finished].freeze

  belongs_to :group
  belongs_to :affiliation
  has_many :players

  alias_attribute :creator, :affiliation

  enum status: MATCH_STATUSES, _prefix: true

  validates :group, :affiliation, :name, :date, :location, :min_players, :max_players, :status, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  validates :min_players, :max_players, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :date, inclusion: { in: (Time.zone.now..Time.zone.now + 5.years) }, unless: -> { finished? }
  validate :affiliation_group
  validate :min_max_players, unless: -> { min_players.nil? || max_players.nil? }
  validate :players_before_confirm
  validate :blocked_fields, if: -> { status_was == 'finished' }

  MATCH_STATUSES.each do |type|
    define_method "#{type}?" do
      status == type
    end
  end

  def confirm
    update!(status: 'confirmed')
  end

  def finish
    update!(status: 'finished')
  end

  def user_admin?(user)
    group&.admin?(user)
  end

  private

  def affiliation_group
    errors.add(:group, 'group should be the same than the affiliation') if affiliation&.group != group
  end

  def min_max_players
    errors.add(:max_players, 'max players should be higher than min players') if min_players > max_players
  end

  def players_before_confirm
    return unless confirmed?
    attending_players = players.attending.count
    errors.add(:status, 'you cannot confirm a match if the min number of player has not been reached') if attending_players < min_players
    errors.add(:status, 'you cannot confirm a match if there are more players than the max players number') if attending_players > max_players
  end

  def blocked_fields
    errors.add(:name, 'you cannot change the name of the finished match') if name_changed?
    errors.add(:date, 'you cannot change the date of the finished match') if date_changed?
    errors.add(:duration, 'you cannot change the duration of the finished match') if duration_changed?
    errors.add(:location, 'you cannot change the location of the finished match') if location_changed?
    errors.add(:min_players, 'you cannot change the min players of the finished match') if min_players_changed?
    errors.add(:max_players, 'you cannot change the max players of the finished match') if max_players_changed?
    errors.add(:status, 'you cannot change the status of the finished match') if status_changed?
    errors.add(:latitude, 'you cannot change the latitude of the finished match') if latitude_changed?
    errors.add(:longitude, 'you cannot change the longitude of the finished match') if longitude_changed?
  end
end