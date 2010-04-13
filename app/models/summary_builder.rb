class SummaryBuilder
  def initialize(account)
    first_movement = account.movements.last
    @account = account
    @start = Date.from_db(first_movement.date)
    @start = Date.civil(@start.year, @start.month, 1)
    @finish = Date.today
    @finish = Date.civil(@finish.year, @finish.month, 1)
    create_summaries
    
  end

  def create_summaries
    current = @start
    while current <= @finish
      MonthSummary.get(@account.id, current.year, current.month)
      current = current + 1.month
    end
  end
end
