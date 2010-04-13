class UserAccountMonthSummariesController < ApplicationController
  before_filter :require_user
  
  def show
    @account = current_user.accounts.find(params[:account_id])
    year = params[:id][0..3]
    month = params[:id][5..-1]
    @summary = @account.month_summaries.find_by_year_and_month(year, month)
  end
end
