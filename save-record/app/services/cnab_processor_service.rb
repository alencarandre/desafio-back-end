class CnabProcessorService < ApplicationService
  def initialize(cnab)
    @cnab = cnab
    @transaction_hash = @cnab.transaction_hash
  end

  def call
    return if has_movement?

    Movement.create!(movement_data)
  end

  private

  def has_movement?
    Movement
      .where(transaction_hash: @transaction_hash)
      .present?
  end

  def movement_data
    {
      transaction_type: transaction_type,
      store: store,
      owner: owner,
      transaction_date: @cnab.datetime,
      value: value,
      document: @cnab.document,
      card: @cnab.card,
      transaction_hash: @transaction_hash,
    }
  end

  def transaction_type
    @transaction_type ||= TransactionType.find(@cnab.transaction_type)
  end

  def store
    @store ||= Store.where(name: @cnab.store).first_or_create!
  end

  def owner
    @owner ||= Owner.where(name: @cnab.owner).first_or_create!
  end

  def value
    if transaction_type.operation.outgoing?
      @cnab.value * -1
    else
      @cnab.value
    end
  end
end
