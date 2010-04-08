class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :number, :length => 10
      t.string :entity_code, :length => 4
      t.string :office_code, :length => 4
      t.string :control_code, :length => 2
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
