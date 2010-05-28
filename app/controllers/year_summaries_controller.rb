class YearSummariesController < ApplicationController
  before_filter :require_user
  
  def show
    @year = params[:id].to_i
    @account = Account.find(params[:account_id])
    @movements = @account.movements_between(Date.civil(@year, 1, 1), Date.civil(@year, 12, 31))
    if @movements.size > 0
      @period = Period.new(@account, @movements)
    end

  end
end
