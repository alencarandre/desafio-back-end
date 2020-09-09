class AddOwnerToStore < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :owner_id, :bigint, null: false
    add_foreign_key :stores, :owners

    remove_index :stores, :name

    add_index :stores, [:owner_id, :name], unique: true
  end
end
