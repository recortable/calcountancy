class Movement < ActiveRecord::Base
  default_scope :order => 'DATE desc, id desc'
  validates_presence_of :account_id, :date, :ammount, :balance, :concept
  before_save :generate_code
  belongs_to :account
  attr_accessor :import

  has_many :taggings
  has_many :tags, :through => :taggings

  def fecha
    d.fecha
  end

  def d
    @d ||= Date.from_db(self.date)
  end

  def import?
    import == 'import'
  end

  def type
    ammount < 0 ? 'negative' : 'positive'
  end

  def before_balance
    balance - ammount
  end

  def generate_code
    self.code = "#{self.date}#{self.ammount}#{self.balance}"
  end
end
