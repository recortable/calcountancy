class UserTagsController < ApplicationController
  before_filter :require_user
  def index
    @user = current_user
    @accounts = current_user.accounts
  end
end
