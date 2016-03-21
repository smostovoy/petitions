class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :petition

  validates :user_id, uniqueness: { scope: :petition_id}
  validate :validate_petition_is_not_expired, on: :create

  def validate_petition_is_not_expired
    errors.add(:base, I18n.t('petition.errors.expired')) if petition.expired?
  end
end
