class Task < ApplicationRecord
  STATUSES = %w[Pending Completed].freeze

  before_validation :strip_text_fields

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 5000 }
  validates :status, inclusion: { in: STATUSES, message: "must be Pending or Completed" }

  scope :newest_first, -> { order(created_at: :desc, id: :desc) }
  scope :with_status, ->(status) { where(status: status) }

  def completed?
    status == "Completed"
  end

  # Switches between Pending and Completed.
  def toggle_status!
    update!(status: completed? ? "Pending" : "Completed")
  end

  # True when the task was changed after it was created.
  def edited?
    updated_at.present? && created_at.present? && (updated_at - created_at) > 1.second
  end

  private

  def strip_text_fields
    self.title = title.strip if title.respond_to?(:strip)
    self.description = description.strip if description.respond_to?(:strip)
  end
end
