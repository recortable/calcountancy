class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :holders
  has_many :accounts, :through => :holders
end
