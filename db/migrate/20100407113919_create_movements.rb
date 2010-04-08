class CreateMovements < ActiveRecord::Migration
  def self.up
    create_table :movements do |t|
      t.references :account
      t.string :code, :length => 48
      t.string :date, :length => 8
      t.integer :ammount
      t.integer :balance
      t.string :concept, :length => 256
      t.string :comments
      t.timestamps
    end

    add_index :movements, :date
  end

  def self.down
    drop_table :movements
  end
end
