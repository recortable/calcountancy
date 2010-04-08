class Movement < ActiveRecord::Base
  default_scope :order => 'DATE desc, id desc'
  validates_presence_of :account_id, :date, :ammount, :balance, :concept
  before_save :generate_code
  belongs_to :account
  attr_accessor :import

  has_many :taggings
  has_many :tags, :through => :taggings

  def fecha
    Date.from_db(self.date).fecha
  end

  def balance_es
    "%5.2f" % (self.balance.to_f / 100)
  end

  def ammount_es
    "%5.2f" % (self.ammount.to_f / 100)
  end


  def generate_code
    self.code = "#{self.date}#{self.ammount}#{self.balance}"
  end
end
