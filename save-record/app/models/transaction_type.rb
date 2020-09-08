class TransactionType < ApplicationRecord
  extend Enumerize

  enumerize :operation, in: %i(incoming outgoing)

  validates :id,
    :operation,
    :description,
    presence: true

end
