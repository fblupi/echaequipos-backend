class Player < ApplicationRecord
  belongs_to :affiliation
  belongs_to :match

  validate :match_status, on: :create
  validate :affiliation_match
  validate :attendance_of_confirmed_match

  scope :attending, -> { where(attendance: true) }

  def confirm!
    update!(attendance: true)
  end

  def quit!
    update!(attendance: false)
  end

  private

  def match_status
    errors.add(:match, 'match should be proposal') unless match&.proposal?
  end

  def affiliation_match
    errors.add(:match, 'match group should be the same than the affiliation') if affiliation&.group != match&.group
  end

  def attendance_of_confirmed_match
    return if match&.proposal? || !persisted?
    errors.add(:attendance, 'you cannot change the attendance of a confirmed match') if attendance_changed?
  end
end