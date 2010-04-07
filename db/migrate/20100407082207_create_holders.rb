class CreateHolders < ActiveRecord::Migration
  def self.up
    create_table :holders do |t|
      t.references :user
      t.references :account
      t.string :rol, :length => '10', :default => 'owner'
      t.timestamps
    end
  end

  def self.down
    drop_table :holders
  end
end
