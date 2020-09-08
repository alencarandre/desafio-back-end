class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :movements do |t|
      t.references :transaction_type, null: false, foreign_key: true
      t.datetime :transaction_date, null: false
      t.float :value, null: false
      t.string :document, null: false
      t.string :card, null: false
      t.references :owner, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.string :transaction_hash, null: false, unique: true

      t.timestamps
    end
  end
end
