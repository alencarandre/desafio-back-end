class Store < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false, scope: :owner_id }
  
  belongs_to :owner
  has_many :movements

  scope :with_amount, -> do
    select('stores.id, stores.name, SUM(movements.value) AS total_amount')
    .joins(:movements)
    .group('stores.id, stores.name')
  end
end
