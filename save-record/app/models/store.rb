class Store < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false, scope: :owner_id }
  
  belongs_to :owner
  has_many :movements

  scope :summary, -> do
    select("
      stores.id,
      stores.name,
      owners.name AS owner_name,
      SUM(movements.value) AS total_amount
    ").joins(:movements)
    .joins(:owner)
    .group('stores.id, stores.name, owners.name')
    .order('stores.id')
  end
end
