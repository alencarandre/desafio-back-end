class Cnab
  include ActiveModel::Model

  attr_accessor :transaction_type,
    :datetime,
    :value,
    :document,
    :card,
    :owner,
    :store,
    :processing_id
  
  validates :transaction_type,
    :datetime,
    :value,
    :document,
    :card,
    :owner,
    :store,
    presence: true
  
  def serialize
    to_json(except: ['errors', 'validation_context'])
  end
end
