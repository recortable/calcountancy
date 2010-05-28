# To change this template, choose Tools | Templates
# and open the template in the editor.

class Period
  attr_reader :account, :movements

  def initialize(account, movements)
    @account = account
    @movements = movements
  end

  def begin_date
    @begin_date ||= Date.from_db(first_movement.date)
  end

  def before_balance
    @before_balance ||= first_movement.balance
  end

  def after_balance
    @after_balance ||= last_movement.balance
  end

  def balance
    positive_ammount + negative_ammount
  end

  def end_date
    @end_date ||= Date.from_db(last_movement.date)
  end

  def first_movement
    @first_movement ||= @movements.last
  end

  def last_movement
    @last_movement ||= @movements.first
  end

  def positive_ammount
    @positive_ammount ||= @movements.inject(0) {|sum, movement| movement.ammount > 0 ? sum + movement.ammount : sum}
  end

  def negative_ammount
    @negative_ammount ||= @movements.inject(0) {|sum, movement| movement.ammount < 0 ? sum + movement.ammount : sum}
  end

  def negative_percent
    @negative_percent ||= positive_ammount > 0 ? (100 * negative_ammount / positive_ammount) : 'no hay '
  end
end
