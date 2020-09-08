class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end
  end
end
