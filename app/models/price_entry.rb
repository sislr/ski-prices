class PriceEntry < ApplicationRecord
  belongs_to :ski_pass

  scope :ordered_by_date, -> { order(created_at: :asc) }

  validates :price_in_chf, presence: true, numericality: { greater_than: 0 }
  validate :ski_pass_date_is_not_in_past

  private

  def ski_pass_date_is_not_in_past
    return unless ski_pass.valid_on.past?

    errors.add(:base, "Cannot create price entry for past dates")
  end
end
