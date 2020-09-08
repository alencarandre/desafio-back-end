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
  
  def transaction_hash
    hash = "#{datetime.to_s}#{value}#{document}#{card}#{owner}#{store}"
    Digest::SHA256.hexdigest(hash)
  end
end
