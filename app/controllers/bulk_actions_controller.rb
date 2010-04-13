class BulkActionsController < ApplicationController
  before_filter :require_user

  def create
    @action = BulkAction.new(current_user, params[:bulk_action])
    @action.save
  end
end
