class InvolvedCompany < ApplicationRecord
  belongs_to :company
  belongs_to :game

  validates :developer, :publisher, inclusion: { in: [true, false] }

  validates :company, uniqueness: { scope: :game, message: "and Game combination already taken" }
end
