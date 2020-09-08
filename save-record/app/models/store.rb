class Store < ApplicationRecord
  belongs_to :owner

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }
end
