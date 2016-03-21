class Petition < ActiveRecord::Base
  EXPIRATION_DAYS = 30
  NEEDED_VOTES = 100

  belongs_to :user

  has_many :votes

  scope :expired, -> { where('DATE(created_at) < ?', EXPIRATION_DAYS.days.ago) }

  validate :validate_petition_is_not_expired, on: :update

  def validate_petition_is_not_expired
    errors.add(:base, I18n.t('petition.errors.expired')) if expired?
  end

  def expired?
    created_at < EXPIRATION_DAYS.days.ago
  end

  def collected_votes?
    votes.count >= NEEDED_VOTES
  end

  def days_left
    return 0 if expired?
    (created_at + EXPIRATION_DAYS.days - Time.now).divmod(60*60*24)[0]
  end

  def voted_by?(user)
    votes.where(user_id: user.id).any?
  end

  def owner?(other_user)
    user == other_user
  end
end
