class Game < ApplicationRecord
  has_one_attached :image
  belongs_to :parent, class_name: "Game", optional: true
  has_many :involved_companies, dependent: :destroy
  has_many :companies, through: :involved_companies
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  has_many :critics, as: :criticable, dependent: :destroy
 
  enum category: { main_game: 0, expansion: 1 }

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :rating,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 100,
              allow_nil: true
            }

  validate :validate_parent

  has_many :expansions,
           class_name: "Game",
           foreign_key: "parent_id",
           dependent: :destroy,
           inverse_of: "parent"

  private

  def validate_parent
    if category == "main_game" && parent_id
      errors.add(:parent_id, "Should be null")
    elsif category == "expansion" && Game.find_by(id: parent_id).nil?
      errors.add(:parent_id, "Should be a valid game id")
    end
  end
end
