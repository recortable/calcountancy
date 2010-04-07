class Account < ActiveRecord::Base
  validates_presence_of :number, :name, :owner
  has_many :holders
  has_many :users, :through => :holders
end
