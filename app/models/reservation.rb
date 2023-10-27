class Reservation < ApplicationRecord
    belongs_to :guest, class_name: 'User'
    belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_cannot_be_before_start_date

  def end_date_cannot_be_before_start_date
    errors.add(:end_date, "can't be before start date") if end_date < start_date
  end

  before_save :check_date_overlap

  def check_date_overlap
    # Проверка пересечения дат
    if self.listing.reservations.where("start_date <= ? AND end_date >= ?", self.end_date, self.start_date).exists?
      errors.add(:base, "Даты резервации пересекаются с другой резервацией")
      throw :abort
    end
  end
end
