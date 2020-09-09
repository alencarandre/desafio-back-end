class Movement < ApplicationRecord
  belongs_to :transaction_type
  belongs_to :owner
  belongs_to :store

  validates :transaction_date,
    :value,
    :document,
    :card,
    presence: true

  validates :transaction_hash,
    presence: true,
    uniqueness: true
end
