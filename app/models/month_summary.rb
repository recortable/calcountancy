class MonthSummary < ActiveRecord::Base
  belongs_to :account
  before_save :calculate

  def movements
    account.movements_between(begin_date, end_date)
  end

  def type
    balance < 0 ? 'negative' : 'positive'
  end

  def balance
    @balance ||= positive_ammount + negative_ammount
  end

  def begin_date
    @begin_date ||= Date.civil(year, month, 1)
  end

  def end_date
    @end_date ||= begin_date + 1.month - 1.day
  end

  def to_param
    "#{year}-#{month}"
  end

  def self.get(account_id, year, month)
    MonthSummary.find_or_create_by_account_id_and_year_and_month(account_id, year, month)
  end

  private
  def calculate
    self.positive_ammount = 0
    self.negative_ammount = 0
    all = self.movements
    if all.count > 0
      self.before_balance = all.last.before_balance
      self.after_balance = all.first.balance
      all.each do |movement|
        if movement.ammount >= 0
          self.positive_ammount = self.positive_ammount + movement.ammount
        else
          self.negative_ammount = self.negative_ammount + movement.ammount
        end
      end
    else
      last = account.movements.first
      self.before_balance = last.balance
      self.after_balance = last.balance
    end
  end
end
