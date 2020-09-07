class CreateCnabFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :cnab_files do |t|
      t.string :status

      t.timestamps
    end
  end
end
