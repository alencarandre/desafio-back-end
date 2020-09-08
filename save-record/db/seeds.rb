TransactionType.where(id: 1).first_or_create!(
  description: 'Debit',
  operation: :incoming
)
TransactionType.where(id: 2).first_or_create!(
  description: 'Boleto',
  operation: :outgoing
)
TransactionType.where(id: 3).first_or_create!(
  description: 'Financing',
  operation: :outgoing
)
TransactionType.where(id: 4).first_or_create!(
  description: 'Credit',
  operation: :incoming
)
TransactionType.where(id: 5).first_or_create!(
  description: 'Lending',
  operation: :incoming
)
TransactionType.where(id: 6).first_or_create!(
  description: 'Sales',
  operation: :incoming
)
TransactionType.where(id: 7).first_or_create!(
  description: 'TED',
  operation: :incoming
)
TransactionType.where(id: 8).first_or_create!(
  description: 'DOC',
  operation: :incoming
)
TransactionType.where(id: 9).first_or_create!(
  description: 'Rent',
  operation: :outgoing
)
