class User < ApplicationRecord
  has_many :critics, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

end
