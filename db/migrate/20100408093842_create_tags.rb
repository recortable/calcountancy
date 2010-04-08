class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.string :color, :default => '#E1E4E4', :length => 12
      t.references :account
      t.integer :size, :default => 0
    end
    
    create_table :taggings do |t|
      t.column :tag_id, :integer
      t.column :movement_id, :integer
      t.column :user_id, :integer
      t.column :created_at, :datetime
    end
    
    add_index :taggings, :tag_id
  end
  
  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
