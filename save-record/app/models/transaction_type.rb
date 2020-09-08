class TransactionType < ApplicationRecord
  extend Enumerize

  enumerize :status, in: %i(incoming outgoing)

  validates :id,
    :operation,
    :description,
    presence: true

end
