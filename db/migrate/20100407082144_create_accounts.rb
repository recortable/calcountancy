class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :number, :length => 30
      t.string :name
      t.string :address
      t.string :owner
      t.string :owner_address
      t.string :bic, :length => 30
      t.string :iban, :length => 30
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
