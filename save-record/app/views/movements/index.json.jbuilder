json.id @store.id
json.name @store.name
json.movements do
  json.array! @movements do |movement|
    json.id movement.id
    json.transaction_date movement.transaction_date
    json.transaction_description movement.transaction_type.description
    json.operation movement.transaction_type.operation
    json.document movement.document
    json.card movement.card
    json.value movement.value
  end
end
