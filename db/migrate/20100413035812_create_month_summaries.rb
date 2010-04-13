class CreateMonthSummaries < ActiveRecord::Migration
  def self.up
    create_table :month_summaries do |t|
      t.references :account, :required => true
      t.integer :year, :required => true
      t.integer :month, :required => true
      t.integer :positive_ammount, :default => 0
      t.integer :negative_ammount, :default => 0
      t.integer :before_balance, :default => 0
      t.integer :after_balance, :default => 0
      t.string :tag_summary, :length => 4096
      t.string :comments
      t.timestamps
    end

    add_index :month_summaries, :year
    add_index :month_summaries, :month

    Account.all.each {|a| SummaryBuilder.new(a) }

  end

  def self.down
    drop_table :month_summaries
  end
end
