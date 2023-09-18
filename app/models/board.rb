class Board < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :content, presence: true
  validates :content, uniqueness: true
end
