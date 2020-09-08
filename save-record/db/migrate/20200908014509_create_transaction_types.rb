class CreateTransactionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_types do |t|
      t.string :operation, null: false
      t.string :description, null: false

      t.timestamps
    end

    change_column :transaction_types, :id, :integer, default: nil
  end
end
