# To change this template, choose Tools | Templates
# and open the template in the editor.

class Tag < ActiveRecord::Base
  belongs_to :account
  has_many :taggings
  has_many :movements, :through => :taggings

  validates_presence_of :name, :color
end
