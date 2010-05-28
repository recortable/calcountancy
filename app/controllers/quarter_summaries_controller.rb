class QuarterSummariesController < ApplicationController
  before_filter :require_user

  def show
    @year = params[:id][0..4].to_i
    @quarter = params[:id][6..6].to_i
    case @quarter
    when 1
      from_date = Date.civil(@year, 1, 1)
      to_date = Date.civil(@year, 3, 31)
    when 2
      from_date = Date.civil(@year, 4, 1)
      to_date = Date.civil(@year, 6, 30)
    when 3
      from_date = Date.civil(@year, 7, 1)
      to_date = Date.civil(@year, 9, 30)
    when 4
      from_date = Date.civil(@year, 10, 1)
      to_date = Date.civil(@year, 12, 31)
    else
      from_date = Date.civil(@year, 1, 1)
      to_date = Date.civil(@year - 1, 1, 1)
    end

    @account = Account.find(params[:account_id])
    @movements = @account.movements_between(from_date, to_date)
    if @movements.size > 0
      @period = Period.new(@account, @movements)
    end

  end
end
