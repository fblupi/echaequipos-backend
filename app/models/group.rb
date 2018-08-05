class Group < ApplicationRecord
  validates :name, presence: true

  has_many :affiliations
  has_many :users, through: :affiliations

  Affiliation::AFFILIATION_TYPES.each do |type|
    define_method "#{type}s" do
      users.select { |user| user.affiliations.where(group: self, affiliation_type: type).exists? }
    end

    define_method "is_#{type}?" do |user|
      public_send("#{type}s").include?(user)
    end
  end

  def invite_user(user)
    return if !user || exist_user?(user)
    Affiliation.create(group: self, user: user, affiliation_type: 'invitation')
  end

  def exist_user?(user)
    users.include?(user)
  end
end
