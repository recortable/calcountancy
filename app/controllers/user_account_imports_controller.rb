class UserAccountImportsController < ApplicationController
  before_filter :require_user

  def new
    @account = current_user.accounts.find(params[:account_id])
  end

  def create
    @account = current_user.accounts.find(params[:account_id])
    @movements = []
    begin
      Movement.transaction do
        params[:movement].each do |param|
          movement = Movement.new(param)
          movement.account = @account
          movement.save!
          @movements << movement
        end
        SummaryBuilder.new(@account)
      end
      #flash[:notice] = t('user_account_imports.create.success')
    rescue ActiveRecord::RecordInvalid => e
      @import = Import.new(@account, params[:import])
      #flash[:notice] = t('user_account_imports.create.fail')
      render :action => 'new'
      puts "EXCEPTION #{e}"
    end
  end

  def preview
    @account = current_user.accounts.find(params[:account_id])
    @import = Import.new(@account, params[:import])
    render :action => 'new'
  end
end
